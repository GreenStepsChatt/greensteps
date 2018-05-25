class User < ApplicationRecord
  rolify

  has_many :deeds, dependent: :destroy
  has_many :redemptions, dependent: :destroy
  has_many :strikes, dependent: :destroy

  scope :soft_deleted, -> { where.not(deleted_at: nil) }

  # TODO: We definitely need to do some refactoring in here. One idea I had was
  #       to make a scorecard model that is essentially a cache of point
  #       calculations.

  def self.by_total_points(direction = 'DESC')
    with_total_trash_bags.order("total_trash_bags #{direction}")
  end

  def self.with_total_trash_bags
    select <<~SQL
      users.*,
      (
        SELECT COALESCE(SUM(trash_bags), 0) FROM deeds
        WHERE user_id = users.id
      ) AS total_trash_bags
    SQL
  end

  def self.order_by(attribute, direction = 'ASC')
    if column_names.include? attribute.to_s
      order("#{attribute} #{direction}")
    else
      send("by_#{attribute}", direction)
    end
  end

  def total_points
    deeds.total_trash_bags
  end

  def redeemed_points
    redemptions.total_cost
  end

  def unredeemed_points
    total_points - redeemed_points
  end

  def points_redeemed_this_month
    redemptions.this_month.total_cost
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
    super && deleted_at.blank? && strikes.count < 3
  end

  def inactive_message
    if deleted_at.present?
      :account_deleted
    elsif strikes.count >= 3
      :deactivated_by_admin
    else
      super
    end
  end

  def send_devise_notification(mailer_method_name, *args)
    devise_mailer.send(mailer_method_name, self, *args).deliver_later
  end
end
