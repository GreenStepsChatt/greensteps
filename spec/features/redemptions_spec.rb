require 'rails_helper'

RSpec.describe 'Redemptions', type: :feature do
  scenario 'User redeems a prize', :js do
    user = create :user
    prize = create :prize, cost: 5
    create_list :deed, 3, trash_bags: 2, user: user
    stubbed_login_as user, follow_to_default_path: true

    prizes_article.redeem(prize)

    expect(page).to flash_message t('redemptions.create.success')
    expect(prizes_article.unredeemed_points).to eq user.unredeemed_points
  end
end
