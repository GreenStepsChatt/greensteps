require 'rails_helper'

RSpec.describe PointCalculator do
  describe '#total_points' do
    it 'gives one point for every trash bag collected' do
      user = instance_double('User', total_trash_bags: 1,
                             total_redeemed_points: 0)
      point_calculator = PointCalculator.new(user)

      expect(point_calculator.total_points).to eq 1
    end
  end
end
