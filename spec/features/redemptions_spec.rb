require 'rails_helper'

RSpec.describe 'Redemptions', type: :feature do
  scenario 'User redeems a prize', :js do
    user = create :user
    prize = create :prize, cost: 5
    create_list :deed, 3, trash_bags: 2, user: user
    stubbed_login_as user, follow_to_default_path: true

    find("label[for='redemption_prize_id_#{prize.id}'] button").click

    expect(page).to flash_message t('redemptions.create.success')
    expect(page).to have_content \
      t('dashboards.redeem_a_prize.available_points', count: current_user.unredeemed_points)
  end
end
