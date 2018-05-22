require 'rails_helper'

RSpec.describe 'dashboards/_redeem_a_prize' do
  let(:user) { create :user, total_points: 35 }
  before(:each) do
    create :redemption, prize: create(:prize, cost: 10), user: user
    redemption_form = RedemptionForm.new(user: user)
    render 'dashboards/redeem_a_prize',
           current_user: user,
           redemption_form: redemption_form
  end

  it { should have_content t('.redeem_a_prize.available_points', count: 20) }
end
