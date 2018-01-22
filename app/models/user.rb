class User < ApplicationRecord
  acts_as_paranoid
  rolify

  has_many :deeds

  def total_trash_bags
    deeds.sum(:trash_bags)
  end

  def total_miles
    deeds.sum(:miles)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
end
