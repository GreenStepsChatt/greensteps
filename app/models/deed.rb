class Deed < ApplicationRecord
  belongs_to :user
  validates :trash_bags,
            numericality: { greater_than: 0 }
  validate :maximum_points_this_month

  attr_accessor :p_left_total

  def maximum_points_this_month
    p_left_this_month = 30 - user.total_points_this_month
    p_left_total = p_left_this_month - total_points_this_deed
    return unless p_left_total.negative?
    self.trash_bags = p_left_this_month
    self.p_left_total = p_left_total.abs
  end

  def total_points_this_deed
    this_deed_class = Struct.new(:total_trash_bags)
    this_deed = this_deed_class
                .new(trash_bags.nil? ? 0 : trash_bags)
    PointCalculator.new(this_deed).total_points
  end

  def points_submitted
    p_left_total + trash_bags
  end
end
