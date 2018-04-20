require 'rails_helper'

RSpec.describe 'Prize management', type: :feature do
  scenario 'Admin adds a new prize', :js do
    stubbed_login_as create(:admin)

    visit admins_dashboard_path
    admin_dashboard.add_prize
    prize_form.title = 'Two free drinks at the brew pub'
    prize_form.quantity = 15
    prize_form.cost = 20
    prize_form.submit

    expect(page).to flash_message t('admins.prizes.create.success')
    expect(prize_list).to include 'Two free drinks'
  end

  scenario 'Admin edits a prize', :js do
    create_and_login_admin
    prize = create :prize
    visit edit_admins_prize_path(prize)
    fill_in 'Title', with: 'New title'
    click_button 'Save'

    expect(page).to flash_message t('admins.prizes.update.success')
    expect(prize_list).to include 'New title'
  end
end
