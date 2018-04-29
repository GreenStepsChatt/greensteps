class PointCalculator
  def initialize(user)
    @user = user
  end

  def total_points
    trash_points
  end

  private

  def trash_points
    @user.total_trash_bags
  end
end
