class Redemption < ApplicationRecord
  belongs_to :user
  belongs_to :prize

  validate :user_has_enough_points, on: :create

  scope :this_month, -> { where(created_at: Time.zone.today.all_month) }

  def user_has_enough_points
    return if user.enough_points_for?(prize)
    errors.add(:base, :not_enough_points)
  end
end
