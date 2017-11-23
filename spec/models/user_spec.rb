require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :deeds }
  it { should have_and_belong_to_many :roles }
  it { should act_as_paranoid }

  it_should_behave_like 'a devise model'

  describe '.total_trash_bags' do
    it 'should give the total number of trash bags the user has collected' do
      user = create :user

      [1, 2, 3].each do |num_bags|
        create(:deed, trash_bags: num_bags, user: user)
      end

      expect(user.total_trash_bags).to eq 6
    end
  end

  describe '.total_miles' do
    it 'should give the total number of miles the user has walked' do
      user = create :user

      [1, 2, 3].each do |num_bags|
        create(:deed, trash_bags: num_bags, user: user)
      end

      expect(user.total_trash_bags).to eq 6
    end
  end
end
