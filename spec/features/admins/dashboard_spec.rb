require 'rails_helper'

RSpec.describe 'Admin dashboard', type: :feature do
  scenario 'Admin logs in and views dashboard' do
    admin = create :admin

    visit root_path
    welcome_page.open_log_in_form
    log_in_form.fill_and_submit_for admin
    appbar.open_drawer
    click_on t('shared.appbar.admin_dashboard')

    expect(page).to show :admin_dashboard
  end

  scenario 'Regular user does not see link to admin dashboard' do
    create_and_login_user

    appbar.open_drawer

    expect(appbar).to_not have_link t('shared.appbar.admin_dashboard')
  end
end
