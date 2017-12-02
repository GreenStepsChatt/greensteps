class Admin
  include ActiveModel::Model

  attr_accessor :email
  validates_presence_of :email
  validate :user_exists

  def save
    if valid?
      user.add_role :admin
    else
      false
    end
  end

  private

  def user
    @user ||= User.where(email: email).first
  end

  def user_exists
    unless user.present?
      errors.add(:email, "must be an existing user's email address")
    end
  end
end
