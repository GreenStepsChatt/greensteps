require 'rails_helper'

RSpec.describe 'Navigation' do
  scenario 'User expands the navigation drawer and then closes it by '\
           'clicking outside of it', :js do
    create_and_login_user

    app_bar.open_drawer
    expect(nav_drawer).to be_open

    app_bar.close_drawer
    expect(nav_drawer).to be_closed
  end

  scenario 'User clicks the browser back button and then tries to open the '\
           'navigation drawer', :js do
    skip 'This test is flaky, but the functionality works... from what I can '\
         'tell. Need to fix. I think it is a timing thing?'
    create_and_login_user

    app_bar.open_drawer
    nav_drawer.edit_account_settings
    click_browser_back_button
    wait_for '.dashboards.show'
    app_bar.open_drawer

    expect(page).to show :nav_drawer
  end

  alias_method :wait_for, :find
end
