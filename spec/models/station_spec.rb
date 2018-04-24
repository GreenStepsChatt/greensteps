require 'rails_helper'

RSpec.describe Station, type: :model do
  subject { build_stubbed :station }

  it { should have_db_column(:name).of_type(:string) }
  it { should have_one(:address) }
  it { should validate_presence_of(:name) }

  describe '#latitude' do
    context 'when the admin entered a street address' do
      it 'returns the latitude from geocoding', :immediately_execute_jobs do
        create :station_form
        station = Station.first
        address = Address.first

        expect(station.latitude).to eq address.latitude
      end
    end

    context 'when the admin entered coordinates' do
      it 'returns the manually entered latitude' do
        create :station_form, :with_coords_only
        station = Station.first
        coordinate_pair = CoordinatePair.first

        expect(station.latitude).to eq coordinate_pair.latitude
      end
    end
  end

  describe '#longitude' do
    context 'when the admin entered a street address' do
      it 'returns the longitude from geocoding', :immediately_execute_jobs do
        create :station_form
        station = Station.first
        coordinate_pair = CoordinatePair.first

        expect(station.longitude).to eq coordinate_pair.longitude
      end
    end

    context 'when the admin entered coordinates' do
      it 'returns the manually entered longitude' do
        create :station_form, :with_coords_only
        station = Station.first
        coordinate_pair = CoordinatePair.first

        expect(station.longitude).to eq coordinate_pair.longitude
      end
    end
  end

  describe '#reverse_coordinates' do
    it 'returns an array with longitude first' do
      create :station_form, :with_coords_only
      station = Station.first
      coordinate_pair = CoordinatePair.first

      expect(station.reverse_coordinates).to eq \
        [coordinate_pair.longitude, coordinate_pair.latitude]
    end
  end

  describe '#street_address' do
    context 'when there is an associated address record' do
      it 'delegates to address.to_sentence' do
        create :station_form, street: '101 Main St', city: 'Boulder',
               state: 'CO', zip: '80304'
        station = Station.first

        expect(station.street_address).to eq '101 Main St, Boulder, CO 80304'
      end
    end

    context 'when there is not an associated address' do
      it 'prints the latitude and longitude' do
        create :station_form, :no_street_address, latitude: 10.0,
               longitude: 20.0
        station = Station.first

        expect(station.street_address).to eq '10.0, 20.0'
      end
    end
  end
end
