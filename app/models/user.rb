class User < ApplicationRecord
  rolify

  has_many :deeds, dependent: :destroy

  scope :soft_deleted, -> { where.not(deleted_at: nil) }

  def total_trash_bags
    deeds.sum(:trash_bags)
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
