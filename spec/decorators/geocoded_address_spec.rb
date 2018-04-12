require 'rails_helper'

RSpec.describe GeocodedAddress do
  describe '#save' do
    context 'for a new address' do
      it 'enqueues a GeocodeJob', :with_active_job_test_adapter do
        address = build :address

        GeocodedAddress.new(address).save

        expect(GeocodeJob).to have_been_enqueued
      end
    end

    context 'when the *value* of an existing address is changed' do
      it 'deletes the old coordinate pair record' do
        address = create :address, :with_coordinate_pair

        GeocodedAddress.new(address).update(street: '111 New St.')

        expect(address.coordinate_pair).to be_destroyed
      end

      it 'enqueues a GeocodeJob', :with_active_job_test_adapter do
        address = create :address, :with_coordinate_pair

        GeocodedAddress.new(address).update(street: '111 New St.')

        expect(GeocodeJob).to have_been_enqueued
      end
    end

    context "when an address is updated but it's value doesn't change" do
      it 'does not delete the coordinate pair record' do
        address = create :address, :with_coordinate_pair

        GeocodedAddress.new(address).update(updated_at: Time.now)

        expect(address.coordinate_pair).to_not be_destroyed
      end

      it 'does not enqueue a GeocodeJob', :with_active_job_test_adapter do
        address = create :address, :with_coordinate_pair

        GeocodedAddress.new(address).update(updated_at: Time.now)

        expect(GeocodeJob).to_not have_been_enqueued
      end
    end
  end

  describe '#geocode' do
    it 'gets coordinates from the API service and stores them in a new record' do
      address = create :address, coordinate_pair: nil

      GeocodedAddress.new(address).geocode

      expect(address.reload.coordinate_pair).to have_attributes stubbed_coords
    end
  end
end
