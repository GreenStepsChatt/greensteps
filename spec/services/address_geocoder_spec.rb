require 'rails_helper'

RSpec.describe AddressGeocoder do
  describe '#new' do
    it 'raises an error if the address is a new record' do
      address = build :address

      expect { AddressGeocoder.new(address) }.to raise_error \
        AddressGeocoder::AddressNotSavedError
    end

    it 'raises an error if the address has been updated and not saved' do
      address = create :address
      address.street = '999 New Street'

      expect { AddressGeocoder.new(address) }.to raise_error \
        AddressGeocoder::AddressNotSavedError
    end
  end

  describe '#geocode' do
    context "when the address's coordinate_pair is not stale" do
      it 'does not enque the geocode job', :with_active_job_test_adapter do
        address = build_stubbed :address
        allow(address).to receive(:coordinate_pair_stale?).and_return(false)

        AddressGeocoder.new(address).geocode

        expect(GeocodeJob).to_not have_been_enqueued
      end
    end

    context "when the address's coordinate_pair is stale" do
      it 'enques the geocode job', :with_active_job_test_adapter do
        address = create :address
        allow(address).to receive(:coordinate_pair_stale?).and_return(true)

        AddressGeocoder.new(address).geocode

        expect(GeocodeJob).to have_been_enqueued
      end
    end

    context 'when the address is a NullAddress' do
      it 'does not enque the geocode job', :with_active_job_test_adapter do
        address = StationForm::NullAddress.new

        AddressGeocoder.new(address).geocode

        expect(GeocodeJob).to_not have_been_enqueued
      end
    end
  end
end
