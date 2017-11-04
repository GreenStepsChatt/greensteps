class User < ApplicationRecord
  has_many :deeds

  def total_trash_bags
    deeds.sum(:trash_bags)
  end

  def total_miles
    deeds.sum(:miles)
  end

  def total_points
    trash_points + mile_points
  end

  def trash_points
    total_trash_bags * 4
  end

  def mile_points
    total_miles
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
