class Redemption < ApplicationRecord
  belongs_to :user
  belongs_to :prize

  validate :user_has_enough_points, on: :create

  def user_has_enough_points
    return if user.unredeemed_points >= prize.cost
    errors.add(:base, :not_enough_points)
  end
end
