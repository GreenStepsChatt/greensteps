class User < ApplicationRecord
  rolify

  has_many :deeds, dependent: :destroy
  has_many :redemptions, dependent: :nullify
  has_many :prizes, through: :redemptions

  scope :soft_deleted, -> { where.not(deleted_at: nil) }

  def total_points
    deeds.sum(:trash_bags)
  end

  def redeemed_points
    prizes.sum(:cost)
  end

  def unredeemed_points
    total_points - redeemed_points
  end

  def enough_points_for?(prize)
    prize.cost <= unredeemed_points
  end

  alias can_redeem? enough_points_for?

  def cannot_redeem?(prize)
    !can_redeem?(prize)
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
