class User < ApplicationRecord
  acts_as_paranoid
  rolify

  has_many :deeds, dependent: :destroy

  def total_trash_bags
    deeds.sum(:trash_bags)
  end

  def total_trash_bags_this_month
    deeds
      .where(created_at: Time
                             .zone
                             .today
                             .beginning_of_month..Time
                                                      .zone
                                                      .today
                                                      .end_of_month)
      .sum(:trash_bags)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  def send_devise_notification(mailer_method_name, *args)
    devise_mailer.send(mailer_method_name, self, *args).deliver_later
  end
end
