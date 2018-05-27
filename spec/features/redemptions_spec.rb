require 'rails_helper'

RSpec.describe 'Redemptions', type: :feature do
  scenario 'User with 5 points requests a gift card', :js do
    user = create :user, total_points: 5
    stubbed_login_as user, follow_to_default_path: true

    dashboard.request_gift_card

    expect(page).to flash_message t('redemptions.create.success')
    expect(dashboard).to_not have_gift_card_button
    expect(dashboard.points_redeemed_this_month).to eq 5
  end
end
