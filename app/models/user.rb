class User < ApplicationRecord
  rolify

  has_many :deeds, dependent: :destroy
  has_many :redemptions, dependent: :nullify
  has_many :prizes, through: :redemptions
  has_many :strikes

  scope :soft_deleted, -> { where.not(deleted_at: nil) }

  def self.by_total_points
    with_total_trash_bags.order('total_trash_bags DESC')
  end

  def self.with_total_trash_bags
    select <<~SQL
      users.*,
      (
        SELECT SUM(trash_bags) FROM deeds
        WHERE user_id = users.id
      ) AS total_trash_bags
    SQL
  end

  def total_points
    deeds.total_trash_bags
  end

  def redeemed_points
    prizes.total_cost
  end

  def unredeemed_points
    total_points - redeemed_points
  end

  def points_redeemed_this_month
    prizes.merge(redemptions.this_month).total_cost
  end

  def available_points
    [unredeemed_points, (30 - points_redeemed_this_month)].min
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  def soft_delete
    update(deleted_at: Time.zone.now)
  end

  def active_for_authentication?
    super && deleted_at.blank?
  end

  def inactive_message
    deleted_at.blank? ? super : :account_deleted
  end

  def send_devise_notification(mailer_method_name, *args)
    devise_mailer.send(mailer_method_name, self, *args).deliver_later
  end
end
