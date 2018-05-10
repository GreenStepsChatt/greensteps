class RedemptionValidator < ActiveModel::Validator
  def validate(r)
    if PointCalculator.new(r.user).total_points < r.cost
      r.errors.add(:cost, "You do not have enough points for this prize!")
    end
  end
end
