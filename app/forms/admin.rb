class Admin < ApplicationForm
  attr_accessor :email
  validates_presence_of :email
  validate :user_exists

  def save
    super do
      user.add_role :admin
    end
  end

  private

  def user
    @user ||= User.where(email: email).first
  end

  def user_exists
    errors.add(:email, :user_does_not_exist) if user.blank?
  end
end
