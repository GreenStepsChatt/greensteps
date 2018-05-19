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
end
