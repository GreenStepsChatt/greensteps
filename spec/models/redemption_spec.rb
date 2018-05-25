require 'rails_helper'
require Rails.root.join('lib', 'factory_helpers', 'add_points_to_user.rb')

RSpec.describe Redemption, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of :value }

  describe '.this_month' do
    it 'returns redemptions that were created this month' do
      user = create :user, total_points: 1
      redemption = create :redemption, value: 1, user: user

      expect(Redemption.this_month).to include redemption
    end

    it 'does not return redemptions created before this month' do
      user = create :user, total_points: 1
      create :redemption, value: 1, user: user, created_at: 2.months.ago

      expect(Redemption.this_month).to be_empty
    end
  end
end
