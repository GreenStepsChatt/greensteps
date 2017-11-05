class PointCalculator
  def initialize(user)
    @user = user
  end

  def total_points
    trash_points + mile_points
  end

  private

  def trash_points
    @user.total_trash_bags * 4
  end

  def mile_points
    @user.total_miles
  end
end
