class AddPointsToUser
  include FactoryBot::Syntax::Methods

  attr_reader :user, :total_points

  def initialize(user, total_points)
    return unless total_points.present? && total_points.positive?

    @total_points = total_points
    @user = user

    add_points_randomly while enough_points_left_for_randomness?
    add_remaining_points
  end

  def add_points_randomly
    create :deed, user: user, trash_bags: random_points_from_available
  end

  def add_remaining_points
    if deeds_left > 1
      create_list :deed, deeds_left, user: user, trash_bags: 1
    else
      create :deed, user: user, trash_bags: points_left
    end
  end

  def random_points_from_available
    Faker::Number.between(1, available_points)
  end

  def available_points
    points_left - deeds_left
  end

  def enough_points_left_for_randomness?
    (points_left > deeds_left) && (deeds_left > 1)
  end

  def points_left
    total_points - user.total_points
  end

  def deeds_left
    deeds_to_create - user.deeds.count
  end

  def deeds_to_create
    @deeds_to_create ||= Faker::Number.between(1, total_points)
  end
end
