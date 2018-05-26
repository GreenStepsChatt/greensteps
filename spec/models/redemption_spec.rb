require 'rails_helper'
require Rails.root.join('lib', 'factory_helpers', 'add_points_to_user.rb')

RSpec.describe Redemption, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of :value }
  it { should validate_numericality_of(:value).is_greater_than_or_equal_to(5) }
  it { should have_db_column :confirmation_number }

  describe '.this_month' do
    it 'returns redemptions that were created this month' do
      user = create :user, total_points: 5
      redemption = create :redemption, value: 5, user: user

      expect(Redemption.this_month).to include redemption
    end

    it 'does not return redemptions created before this month' do
      user = create :user, total_points: 5
      create :redemption, value: 5, user: user, created_at: 2.months.ago

      expect(Redemption.this_month).to be_empty
    end
  end

  describe '.unfulfilled' do
    it 'should include redemptions that do not have a confirmation number' do
      redemption = create :redemption

      expect(Redemption.unfulfilled).to include redemption
    end

    it 'should not include redemptions that have a confirmation number' do
      redemption = create :redemption, :fulfilled

      expect(Redemption.unfulfilled).to_not include redemption
    end
  end
end
