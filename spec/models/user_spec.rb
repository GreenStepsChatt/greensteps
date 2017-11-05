require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :deeds }
  it { should have_and_belong_to_many :roles }

  it_should_behave_like 'a devise model'

  describe '.total_trash_bags' do
    it 'should give the total number of trash bags the user has collected' do
      user = create :user

      [1, 2, 3].each do |num_bags|
        user.deeds << create(:deed, trash_bags: num_bags)
      end

      expect(user.total_trash_bags).to eq 6
    end
  end

  describe '.total_miles' do
    it 'should give the total number of miles the user has walked' do
      user = create :user

      [1, 2, 3].each do |num_bags|
        user.deeds << create(:deed, trash_bags: num_bags)
      end

      expect(user.total_trash_bags).to eq 6
    end
  end

  describe 'with deeds' do
    let(:user) { create(:user, :with_deeds) }

    describe '.total_points' do
      it 'returns the sum of trash_points and mile_points' do
        expect(user.total_points).to eq(user.trash_points + user.mile_points)
      end
    end
    describe '.trash_points' do
      it 'returns 3 points for every trash bag' do
        expect(user.trash_points).to eq(user.total_trash_bags * 4)
      end
    end
    describe '.mile_points' do
      it 'returns 1 point for every mile walked' do
        expect(user.mile_points).to eq user.total_miles
      end
    end
  end
end
