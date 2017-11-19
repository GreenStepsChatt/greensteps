require 'rails_helper'

RSpec.describe 'List of admin users', type: :feature do
  scenario 'Admin logs in and views list of admin users' do
    admin = create :admin

    visit root_path
    welcome_page.open_log_in_form
    log_in_form.fill_and_submit_for admin
    appbar.open_drawer
    click_on t('shared.appbar.adminlist')

    expect(page).to have_content t('shared.appbar.adminlist')
  end

  scenario 'Regular user does not see link to view admin user list' do
    create_and_login_user

    appbar.open_drawer

    expect(appbar).to_not have_link t('shared.appbar.adminlist')
  end

  scenario 'Regular user tries to view list of admins using the url' do
    create_and_login_user

    visit admin_adminlist_index_path

    expect(page).to_not have_content t('admin.adminlist.header')
    expect(page).to flash_message t('restricted_to_admins')
  end
end
