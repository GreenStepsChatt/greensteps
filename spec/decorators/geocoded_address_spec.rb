require 'rails_helper'

RSpec.describe GeocodedAddress do
  context 'the associated coordinates are stale' do
    it 'saving the record starts a GeocodeJob', :with_active_job_test_adapter do
      address = build :address

      GeocodedAddress.new(address).save

      expect(GeocodeJob).to have_been_enqueued
    end
  end

  context 'the associated coordinates are not stale' do
    it 'does not start a GeocodeJob', :with_active_job_test_adapter do
      address = create :address, :with_coordinate_pair

      GeocodedAddress.new(address).save

      expect(GeocodeJob).to_not have_been_enqueued
    end
  end

  context 'the address is not valid' do
    it 'does not start a GeocodeJob', :with_active_job_test_adapter do
      invalid_address = build :address, :invalid

      GeocodedAddress.new(invalid_address).save

      expect(GeocodeJob).to_not have_been_enqueued
    end
  end

  it 'does not add an after_commit callback to undecorated addresses',
     :with_active_job_test_adapter do
    geo_address = build :address
    GeocodedAddress.new(geo_address)
    address = build :address

    address.save

    expect(GeocodeJob).to_not have_been_enqueued
  end
end
