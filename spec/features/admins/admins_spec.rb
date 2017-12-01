require 'rails_helper'

RSpec.describe 'List of admins', type: :feature do
  scenario 'Admin logs in, clicks on link to view list of admins' do
    create_and_login_admin

    visit admins_dashboards_show_path

    click_on t('admins.dashboards.show.miscellaneous.admins')

    expect(page).to have_content t('admins.admins.index.header')
  end

  scenario 'Regular user tries to view list of admins using the url' do
    create_and_login_user

    visit admins_admins_path

    expect(page).to_not have_content t('admins.admins.index.header')
    expect(page).to flash_message t('restricted_to_admins')
  end
end
