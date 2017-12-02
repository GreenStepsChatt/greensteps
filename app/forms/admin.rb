class Admin
  include ActiveModel::Model

  attr_accessor :email

  def save
    user.add_role :admin
  end

  private

  def user
    User.where(email: email).first
  end
end
