require 'rails_helper'

RSpec.describe 'dashboards/_user_stats' do
  let(:user) { create :user, total_points: 35 }
  before(:each) do
    create :redemption, prize: create(:prize, cost: 10), user: user
    render 'dashboards/user_stats', current_user: user
  end

  it { should have_content "#{t('.user_stats.lifetime_points')} 35" }
  it { should have_content "#{t('.user_stats.unredeemed_points')} 25" }
  it do
    should have_content "#{t('.user_stats.points_redeemed_this_month')} 10/30"
  end
end
