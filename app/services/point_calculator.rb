class PointCalculator
  def initialize(user)
    @user = user
  end

  def total_points
    trash_points
  end

  def total_points_this_month
    trash_points_this_month
  end

  private

  def trash_points
    @user.total_trash_bags
  end

  def trash_points_this_month
    @user.total_trash_bags_this_month
  end
end
