class Redemption < ApplicationRecord
  belongs_to :user
  belongs_to :prize

  validate :user_has_enough_points, on: :create
  validate :user_under_monthly_quota, on: :create

  scope :this_month, -> { where(created_at: Time.zone.today.all_month) }

  def user_has_enough_points
    return if user.enough_points_for?(prize)
    errors.add(:base, :not_enough_points)
  end

  def user_under_monthly_quota
    return if user.under_monthly_quota?
    errors.add(:base, :over_quota)
  end
end
