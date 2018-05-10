class PointCalculator
  def initialize(user)
    @user = user
  end

  def total_points
    @user.total_trash_bags - @user.total_redeemed_points
  end
end
