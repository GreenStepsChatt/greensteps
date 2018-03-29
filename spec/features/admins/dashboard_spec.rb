require 'rails_helper'

RSpec.describe 'Admin dashboard', type: :feature do
  scenario 'Admin logs in and views dashboard', :js do
    admin = create :admin

    visit root_path
    welcome_page.open_log_in_form
    log_in_form.fill_and_submit_for admin
    app_bar.open_drawer
    click_on t('shared.navigation.admin_dashboard')

    expect(page).to show :admin_dashboard
  end

  scenario 'Regular user does not see link to admin dashboard', :js do
    create_and_login_user

    app_bar.open_drawer

    expect(app_bar).to_not have_link t('shared.app_bar.admin_dashboard')
  end
end
