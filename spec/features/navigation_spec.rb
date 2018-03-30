require 'rails_helper'

RSpec.describe 'Navigation' do
  scenario 'User expands the navigation drawer and then closes it by '\
           'clicking outside of it', :js do
    create_and_login_user follow_to_default_path: true

    app_bar.open_drawer
    expect(page).to show :nav_drawer

    app_bar.close_drawer
    expect(page).to_not show :nav_drawer
  end

  scenario 'User clicks the browser back button and then tries to open the '\
           'navigation drawer', :js do
    create_and_login_user follow_to_default_path: true

    app_bar.open_drawer
    nav_drawer.edit_account_settings
    wait_for_css '.users-registrations.edit'
    click_browser_back_button
    wait_for_css '.dashboards.show'
    app_bar.open_drawer

    expect(page).to show :nav_drawer
  end
end
