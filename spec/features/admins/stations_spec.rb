require 'rails_helper'

RSpec.describe 'Stations management', type: :feature do
  scenario 'Admin adds a new station with an address', :js,
           :with_active_job_test_adapter do
    create_and_login_admin follow_to_default_path: true

    admin_dashboard.add_station
    station_form.name = 'Downtown - Central'
    station_form.street = '121 Main Street'
    station_form.city = 'Chattanooga'
    station_form.select_state 'Tennessee'
    station_form.zip = '10101'
    station_form.submit

    expect(page).to flash_message t('admins.stations.create.success')
    expect(station_list).to include 'Downtown - Central'
    expect(GeocodeJob).to have_been_enqueued
  end

  scenario 'Admin adds a new address with a lat and long', :js do
    create_and_login_admin

    visit new_admins_station_path
    station_form.name = 'Bushtown'
    station_form.toggle_addr_latlon
    station_form.latitude = 35.042039
    station_form.longitude = -85.283085
    station_form.submit

    expect(page).to flash_message t('admins.stations.create.success')
    expect(station_list).to include 'Bushtown'
  end

  scenario 'Admin can toggle back and forth between street address and '\
    'coordinate fields', :js do
    create_and_login_admin
    visit new_admins_station_path

    expect(page).to_not have_content 'Latitude'

    station_form.toggle_addr_latlon
    expect(page).to have_content 'Latitude'
  end

  scenario 'Admin starts adding an address then switches to coordinates', :js do
    create_and_login_admin
    visit new_admins_station_path

    station_form.name = 'Bushtown'
    station_form.street = '1254 E 3rd St'
    station_form.city = 'Chattanooga'
    station_form.select_state 'Tennessee'
    station_form.zip = '37404'
    station_form.toggle_addr_latlon
    station_form.latitude = 35.042039
    station_form.longitude = -85.283085
    station_form.submit

    station = Station.first
    expect(station.address).to_not be_present
    expect(station.coordinate_pair).to be_present
  end
end
