require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:deeds).dependent(:destroy) }
  it { should have_and_belong_to_many :roles }
  it { should have_many(:redemptions).dependent(:nullify) }
  it { should have_many(:prizes).through(:redemptions) }

  it_should_behave_like 'a devise model'

  describe '.total_points' do
    it 'should give the total number of trash bags the user has collected' do
      user = create :user

      [1, 2, 3].each do |num_bags|
        create(:deed, trash_bags: num_bags, user: user)
      end

      expect(user.total_points).to eq 6
    end
  end

  describe '#redeemed_points' do
    it 'should give the sum of the cost of each prize the user has redeemed' do
      user = create :user
      create :deed, trash_bags: 2, user: user
      create :redemption, prize: create(:prize, cost: 1), user: user

      expect(user.redeemed_points).to eq 1
    end

    xit 'should not query the db if there have been no relevant changes' do
      user = create :user
      create :deed, trash_bags: 2, user: user
      create :redemption, prize: create(:prize, cost: 1), user: user

      user.points_spent
      expect { user.points_spent }.to_not make_database_queries
    end
  end

  describe '#unredeemed_points' do
    it 'should give the total number of points that have not been redeemed' do
      user = create :user
      create :deed, trash_bags: 2, user: user
      create :redemption, prize: create(:prize, cost: 1), user: user

      expect(user.unredeemed_points).to eq 1
    end
  end

  describe '#enough_points_for?' do
    it 'should be false if the prize costs too much' do
      prize = create :prize, cost: 1
      user = create :user

      expect(user.enough_points_for?(prize)).to be_falsey
    end

    it 'should be truthy if the has enough unredeemed points' do
      prize = create :prize, cost: 1
      user = create :user, total_points: 1

      expect(user.enough_points_for?(prize)).to be_truthy
    end
  end

  describe '#cannot_redeem?' do
    it 'should be true if the user has already redeemed 30 points this month' do
      user = create :user
      AddPointsToUser.new(user, 35)
      create :redemption, prize: create(:prize, cost: 30), user: user

      expect(user.cannot_redeem?(build_stubbed(:prize, cost: 5))).to be_truthy
    end
  end

  describe '#under_monthly_quota?' do
    it 'is false if the user has redeemed 30 or more points this month' do
      user = create :user
      AddPointsToUser.new(user, 35)
      create :redemption, prize: create(:prize, cost: 30), user: user

      expect(user.can_redeem?(build_stubbed(:prize, cost: 5))).to be_falsey
    end

    it 'is true if the user has redeemed less than 30 points this month' do
      user = create :user
      AddPointsToUser.new(user, 35)

      expect(user.can_redeem?(build_stubbed(:prize, cost: 5))).to be_truthy
    end
  end

  describe '#soft_delete' do
    it 'should set a value in the `deleted_at` column' do
      user = create :user

      expect { user.soft_delete }.to change(user.reload, :deleted_at).from(nil)
    end
  end

  describe '.soft_deleted' do
    it 'includes users that have delete their account' do
      user = create :user, deleted_at: Time.zone.now

      expect(User.soft_deleted).to include user
    end

    it 'does not include active users' do
      user = create :user

      expect(User.soft_deleted).to_not include user
    end
  end
end
