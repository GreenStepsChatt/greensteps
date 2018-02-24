require 'rails_helper'

RSpec.describe 'Stations management', type: :feature do
  scenario 'Admin adds a new station with an address', :js do
    stubbed_login_as create(:admin)

    appbar.open_drawer
    nav_drawer.open_admin_dashboard
    admin_dashboard.add_station
    station_form.name = 'Downtown - Central'
    station_form.street = '121 Main Street'
    station_form.city = 'Chattanooga'
    station_form.select_state 'Tennessee'
    station_form.zip = '10101'
    station_form.submit

    expect(page).to flash_message t('admins.stations.create.success')
    expect(station_list).to include 'Downtown - Central'
  end
end
