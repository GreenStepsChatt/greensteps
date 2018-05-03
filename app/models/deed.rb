class Deed < ApplicationRecord
  belongs_to :user
  validates :trash_bags, numericality: { greater_than: 0 }
  validate :maximum_points_this_month

  def maximum_points_this_month
    errors.add(:base, :maximum_points) if total_points_this_month > 30
  end

  private

  def total_points_this_month
    this_deed_class = Struct.new(:total_trash_bags)
    this_deed = this_deed_class
                .new(trash_bags.nil? ? 0 : trash_bags)
    PointCalculator
      .new(user)
      .total_points_this_month +
      PointCalculator
      .new(this_deed)
      .total_points
  end
end
