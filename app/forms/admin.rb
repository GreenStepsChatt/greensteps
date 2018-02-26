class Admin < ApplicationForm
  attr_accessor :email
  validates_presence_of :email
  validate :user_exists

  def save!
    user.add_role :admin
  end

  def demote
    user.remove_role :admin
  end

  def self.find(*args)
    new.tap do |admin|
      admin.user = User.with_role(:admin).find(*args)
    end
  end

  # internal
  def user=(user)
    @user = user
    @email = user.email
  end

  private

  def user
    @user ||= User.where(email: email).first
  end

  def user_exists
    errors.add(:email, :user_does_not_exist) if user.blank?
  end
end
