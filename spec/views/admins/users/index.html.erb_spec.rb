require 'rails_helper'

RSpec.describe 'admins/users/index' do
  before(:each) do
    without_partial_double_verification do
      allow(view).to receive(:sort_column).and_return('')
      allow(view).to receive(:sort_direction).and_return('')
    end
  end

  it 'should list the user email' do
    user = create :user

    render template: 'admins/users/index', locals: { users: User.page(1) }

    expect(rendered).to have_content user.email
  end

  it 'should list the user\'s total points' do
    user = create :user, total_points: 6

    render template: 'admins/users/index', locals: { users: User.page(1) }

    expect(rendered).to have_selector "#user_#{user.id} .total_points", text: 6
  end

  it 'should list the user\'s total redeemed points' do
    user = create :user, total_points: 6
    create :redemption, user: user, value: 2

    render template: 'admins/users/index', locals: { users: User.page(1) }

    expect(rendered).to have_selector \
      "#user_#{user.id} .redeemed_points", text: 2
  end

  it 'should list how many points the user has redeemed this month' do
    user = create :user, total_points: 6
    create :redemption, user: user, value: 3
    create :redemption, user: user, value: 2, created_at: 2.months.ago

    render template: 'admins/users/index', locals: { users: User.page(1) }

    expect(rendered).to have_selector \
      "#user_#{user.id} .points_redeemed_this_month", text: 3
  end
end
