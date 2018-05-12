require 'rails_helper'

RSpec.describe 'Stations management', type: :feature do
  scenario 'Admin adds a new station with an address', :js,
           :with_active_job_test_adapter do
    stubbed_login_as create(:admin)

    visit admins_dashboard_path
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
    stubbed_login_as create(:admin)

    visit admins_dashboard_path
    admin_dashboard.add_station
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
    stubbed_login_as create(:admin)

    visit admins_dashboard_path
    admin_dashboard.add_station
    expect(page).to_not have_content 'Latitude'

    station_form.toggle_addr_latlon
    expect(page).to have_content 'Latitude'
  end

  scenario 'Admin edits a station name', :js do
    create_and_login_admin
    station = create :station
    address = create :address
    station.address = address

    visit edit_admins_station_path(station)

    expect(find_field('Name').value).to eq station.name

    fill_in 'Name', with: 'New name'

    click_button 'Save'

    expect(station_list).to include 'New name'
  end

  scenario 'Admin edits a station address', :js do
    create_and_login_admin
    station = create :station
    address = create :address
    station.address = address

    visit edit_admins_station_path(station)

    expect(find_field('address_street').value).to eq address.street
    expect(find_field('address_city').value).to eq address.city
    expect(find_field('address_state').value).to eq address.state
    expect(find_field('address_zip').value).to eq address.zip

    fill_in 'address_street', with: 'New Street'
    fill_in 'address_city', with: 'New City'
    select 'Pennsylvania', from: 'address_state'
    fill_in 'address_zip', with: '00000'

    click_button 'Save'

    visit edit_admins_station_path(station)

    expect(find_field('address_street').value).to eq 'New Street'
    expect(find_field('address_city').value).to eq 'New City'
    expect(find_field('address_state').value).to eq 'PA'
    expect(find_field('address_zip').value).to eq '00000'
  end

  scenario 'Admin edits a station coordinate_pair', :js do
    create_and_login_admin
    station = create :station
    coordinate_pair = create :coordinate_pair
    station.coordinate_pair = coordinate_pair

    visit edit_admins_station_path(station)

    click_button 'use_coordinates'

    expect(find_field('coordinate_pair_longitude').value).to eq coordinate_pair.longitude.to_s
    expect(find_field('coordinate_pair_latitude').value).to eq coordinate_pair.latitude.to_s

    fill_in 'coordinate_pair_longitude', with: 11
    fill_in 'coordinate_pair_latitude', with: 11

    click_button 'Save'

    visit edit_admins_station_path(station)

    click_button 'use_coordinates'

    expect(find_field('coordinate_pair_longitude').value).to eq '11.0'
    expect(find_field('coordinate_pair_latitude').value).to eq '11.0'
  end

  scenario 'Admin adds an address to a station with a coordinate pair which deletes the coordinate pair', :js do
    create_and_login_admin
    station = create :station
    coordinate_pair = create :coordinate_pair
    station.coordinate_pair = coordinate_pair
    visit edit_admins_station_path(station)

    click_button 'use_coordinates'

    expect(find_field('coordinate_pair_longitude').value).to eq coordinate_pair.longitude.to_s
    expect(find_field('coordinate_pair_latitude').value).to eq coordinate_pair.latitude.to_s

    click_button 'use_address'

    fill_in 'street', with: 'New Street'
    fill_in 'city', with: 'New City'
    select 'Pennsylvania', from: 'state'
    fill_in 'zip', with: '00000'
    click_button 'Save'
    visit edit_admins_station_path(station)

    expect(find_field('address_street').value).to eq 'New Street'
    expect(find_field('address_city').value).to eq 'New City'
    expect(find_field('address_state').value).to eq 'PA'
    expect(find_field('address_zip').value).to eq '00000'

    click_button 'use_coordinates'

    expect(find_field('longitude').value).to eq ''
    expect(find_field('latitude').value).to eq ''
  end

  scenario 'Admin adds a coordinate pair to a station with an address which deletes the address', :js do
    create_and_login_admin
    station = create :station
    address = create :address
    station.address = address
    visit edit_admins_station_path(station)

    expect(find_field('address_street').value).to eq address.street
    expect(find_field('address_city').value).to eq address.city
    expect(find_field('address_state').value).to eq address.state
    expect(find_field('address_zip').value).to eq address.zip

    click_button 'use_coordinates'

    fill_in 'longitude', with: 11
    fill_in 'latitude', with: 11

    click_button 'Save'
    visit edit_admins_station_path(station)

    expect(find_field('street').value).to eq ''
    expect(find_field('city').value).to eq ''
    expect(find_field('state').value).to eq ''
    expect(find_field('zip').value).to eq ''

    click_button 'use_coordinates'

    expect(find_field('coordinate_pair_longitude').value).to eq '11.0'
    expect(find_field('coordinate_pair_latitude').value).to eq '11.0'
  end
end
