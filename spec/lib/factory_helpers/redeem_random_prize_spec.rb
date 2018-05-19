require 'rails_helper'
require Rails.root.join('lib', 'factory_helpers', 'redeem_random_prize.rb')

RSpec.describe RedeemRandomPrize do
  let(:user) { create :user }

  it 'creates a redemption when there is an existing redeemable prize' do
    create :deed, user: user, trash_bags: 1
    create :prize, cost: 1

    RedeemRandomPrize.new(user)

    expect(user.redemptions).to have(1).redemption
  end

  it 'creates a redemption when there is not an existing redeemable prize' do
    create :deed, user: user, trash_bags: 1

    RedeemRandomPrize.new(user)

    expect(user.redemptions).to have(1).redemption
  end
end
