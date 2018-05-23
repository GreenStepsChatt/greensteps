require 'rails_helper'

RSpec.describe 'admins/users/index' do
  let(:users) { create_list :user, 3, total_points: 6 }
  let(:user) { users.first }
  before(:each) do
    create :redemption,
           user: user,
           prize: create(:prize, cost: 2),
           created_at: 2.months.ago
    create :redemption, user: user, prize: create(:prize, cost: 3)
    render template: 'admins/users/index', locals: { users: users }
  end

  it 'should list the user emails' do
    users.each do |user|
      expect(rendered).to have_content user.email
    end
  end

  it 'should list the user\'s total points' do
    expect(rendered).to have_selector "#user_#{user.id} .total_points", text: 6
  end

  it 'should list the user\'s total redeemed points' do
    expect(rendered).to have_selector \
      "#user_#{user.id} .redeemed_points", text: 5
  end

  it 'should list how many points the user has redeemed this month' do
    expect(rendered).to have_selector \
      "#user_#{user.id} .points_redeemed_this_month", text: 3
  end
end
