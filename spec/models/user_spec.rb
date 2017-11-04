require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :deeds }

  it { should respond_to :email }
  it { should respond_to :encrypted_password }
  it { should respond_to :reset_password_token }
  it { should respond_to :reset_password_sent_at }
  it { should respond_to :remember_created_at }
  it { should respond_to :sign_in_count }
  it { should respond_to :current_sign_in_at }
  it { should respond_to :last_sign_in_at }
  it { should respond_to :current_sign_in_ip }
  it { should respond_to :last_sign_in_ip }

  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of :password }
  it { should validate_length_of(:password).is_at_least(6).is_at_most(128) }
  it { should allow_value('user@example.com').for(:email) }
  it { should_not allow_values('user', 'user@', '@example.com').for(:email) }

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
