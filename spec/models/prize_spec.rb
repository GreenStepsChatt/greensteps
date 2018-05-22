require 'rails_helper'

RSpec.describe Prize, type: :model do
  subject { build_stubbed :prize }
  it { should validate_numericality_of(:cost).is_greater_than(0) }
  it { should validate_numericality_of(:quantity).is_greater_than(0) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :cost }
  it { should validate_presence_of :quantity }

  describe '.by_cost' do
    it 'orders the prizes by cost' do
      expensive_prize = create :prize, cost: 10
      cheap_prize = create :prize, cost: 1

      expect(Prize.by_cost).to eq [cheap_prize, expensive_prize]
    end
  end

  describe '.total_cost' do
    it 'should add up the total cost of all of the prizes in the scope' do
      [5, 1, 11].each { |n| create :prize, cost: n }

      expect(Prize.total_cost).to eq 17
    end
  end
end
