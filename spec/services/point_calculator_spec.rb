require 'rails_helper'

RSpec.describe PointCalculator do
  describe '#total_points' do
    it 'gives one point for every mile walked' do
      user = instance_double('User', total_miles: 1, total_trash_bags: 0)
      point_calculator = PointCalculator.new(user)

      expect(point_calculator.total_points).to eq 1
    end

    it 'gives four points for every trash bag collected' do
      user = instance_double('User', total_miles: 0, total_trash_bags: 1)
      point_calculator = PointCalculator.new(user)

      expect(point_calculator.total_points).to eq 4
    end

    it 'adds up points from trash bags and miles' do
      user = instance_double('User', total_miles: 2, total_trash_bags: 3)
      point_calculator = PointCalculator.new(user)

      expect(point_calculator.total_points).to eq 14
    end
  end
end
