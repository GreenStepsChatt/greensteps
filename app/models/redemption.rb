class Redemption < ApplicationRecord
  belongs_to :user
  belongs_to :prize

  validate :user_has_enough_points, on: :create
  validate :user_has_enough_quota, on: :create

  scope :this_month, -> { where(created_at: Time.zone.today.all_month) }

  private

  def user_has_enough_points
    return if prize.cost <= user.unredeemed_points
    errors.add(:base, :not_enough_points)
  end

  def user_has_enough_quota
    return if (user.points_redeemed_this_month + prize.cost) <= 30
    errors.add(:base, :would_be_over_quota)
  end
end
