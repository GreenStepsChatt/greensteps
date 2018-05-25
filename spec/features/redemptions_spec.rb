require 'rails_helper'
require Rails.root.join('lib', 'factory_helpers', 'add_points_to_user.rb')

RSpec.describe 'Redemptions', type: :feature do
  scenario 'User with 5 points requests a gift card', :js do
    user = create :user, total_points: 5
    stubbed_login_as user, follow_to_default_path: true

    dashboard.request_gift_card

    expect(page).to flash_message t('redemptions.create.success')
    # expect(dashboard).to_not show_gift_card_button
    expect(page).to have_selector '.new_redemption button', text: 'Request $0 gift card'
  end
end
