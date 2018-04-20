require 'rails_helper'

RSpec.describe 'Dashboard', type: :feature do
  scenario 'Guests are asked to log in first' do
    visit dashboard_path

    expect(page).to show :welcome_page
    expect(page).to flash_message t('no_visitor_access')
  end

  scenario 'User sees map of stations on dashboard' do
    create_and_login_user follow_to_default_path: true

    expect(page).to show :station_map
  end
end
