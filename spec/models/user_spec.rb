require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:deeds).dependent(:destroy) }
  it { should have_and_belong_to_many :roles }
  it { should have_many(:redemptions).dependent(:destroy) }
  it { should have_many(:strikes).dependent(:destroy) }
  it { should have_db_column(:strikes_count) }

  it_should_behave_like 'a devise model'

  describe '.by_total_points' do
    it 'should order the users by total points (desc)' do
      one_point_user = create :user, total_points: 1
      three_point_user = create :user, total_points: 3
      no_point_user = create :user

      expect(User.by_total_points).to eq \
        [three_point_user, one_point_user, no_point_user]
    end

    it 'should respond to `page`' do
      expect(User.by_total_points).to respond_to :page
    end
  end

  describe '.with_total_trash_bags' do
    it 'should include a `total_trash_bags` column' do
      create :user, total_points: 5

      expect(User.with_total_trash_bags.first.total_trash_bags).to eq 5
    end
  end

  describe '.order_by' do
    context 'when the attribute is a column name' do
      it 'delegates to `order`' do
        expect(User).to receive :order
        User.order_by('email')
      end
    end

    context 'when the attribute is not a column name' do
      it 'delegates to `by_attribute`' do
        expect(User).to receive :by_total_points
        User.order_by('total_points')
      end
    end
  end

  describe '#total_points' do
    it 'should give the total number of trash bags the user has collected' do
      user = create :user

      [1, 2, 3].each do |num_bags|
        create(:deed, trash_bags: num_bags, user: user)
      end

      expect(user.total_points).to eq 6
    end
  end

  describe '#redeemed_points' do
    it 'should give the sum of the redemption values' do
      user = create :user
      create :deed, trash_bags: 2, user: user
      create_list :redemption, 2, value: 1, user: user

      expect(user.redeemed_points).to eq 2
    end
  end

  describe '#unredeemed_points' do
    it 'should give the total number of points that have not been redeemed' do
      user = create :user
      create :deed, trash_bags: 2, user: user
      create :redemption, value: 1, user: user

      expect(user.unredeemed_points).to eq 1
    end
  end

  describe '#available_points' do
    context 'when a user has not redeemed anything this month and has less '\
            'than 30 unredeemed points' do
      it 'should equal the total unredeemed points' do
        user = create :user, total_points: 5

        expect(user.available_points).to eq 5
      end
    end

    it 'should account for the maximum of 30 points per month' do
      user = create :user, total_points: 35
      create :redemption, value: 10, user: user

      expect(user.available_points).to eq 20
    end
  end

  describe '#points_redeemed_this_month' do
    it 'should include this month\'s redemptions' do
      user = create :user, total_points: 5
      create :redemption, value: 5, user: user

      expect(user.points_redeemed_this_month).to eq 5
    end

    it 'should not include last month\'s redemptions' do
      user = create :user, total_points: 5
      create :redemption, value: 5, user: user
      create :redemption, value: 3, user: user, created_at: 2.months.ago

      expect(user.points_redeemed_this_month).to eq 5
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
