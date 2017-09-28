require 'rails_helper'

RSpec.describe 'Navigation' do
  scenario 'Visitor expands the navigation drawer and clicks on the homepage '\
           'link', :js do
    visit new_user_session_path # ensure that we aren't on homepage

    appbar.open_drawer
    click_on t(:brand_name)

    expect(page).to have_template :welcome, :index
  end

  scenario 'Anyone expands the navigation drawer and then closes it by '\
           'clicking outside of it', :js do
    visit root_path

    appbar.open_drawer
    expect(nav_drawer).to be_open

    appbar.close_drawer
    expect(nav_drawer).to be_closed
  end

  scenario 'User clicks the browser back button and then tries to open the '\
           'navigation drawer', :js do
    create_and_login_user
    visit root_path

    appbar.open_drawer
    nav_drawer.edit_account_settings
    go_back
    wait_for '.welcome.index'
    appbar.open_drawer

    expect(nav_drawer).to be_open
  end

  alias_method :wait_for, :find
end
