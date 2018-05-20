require 'rails_helper'

RSpec.describe StationForm, type: :form do
  subject { build :station_form }

  it { should respond_to :name, :street, :city, :state, :zip }
  it { should respond_to :latitude, :longitude }

  it 'is invalid when missing both coordinates and address fields' do
    station_form = build :station_form, :no_coordinate_pair, :no_street_address

    station_form.validate

    expect(station_form.errors[:base]).to include(match(/needs either.*or/))
  end

  context 'when given coordinates' do
    subject(:station_form) do
      build :station_form, :no_street_address,
            latitude: 35.042039, longitude: -85.283085
    end

    it { should validate_models :station, :coordinate_pair }

    it 'should create an associated coordinate pair record when saved' do
      expect { station_form.save }.to change { CoordinatePair.count }.by(1)
      expect(CoordinatePair).to include_record_with \
        latitude: 35.042039, longitude: -85.283085
    end
  end

  context 'when given an address' do
    subject(:station_form) do
      build :station_form, :no_coordinate_pair,
            street: '101 Main Street',
            city: 'Chattanooga',
            state: 'TN',
            zip: '10101'
    end

    it { should validate_models :station, :address }

    it 'should create an associated address record when saved' do
      expect { station_form.save }.to change { Address.count }.by(1)
      expect(Address).to include_record_with street: '101 Main Street'
    end
  end

  context 'when given both an address and coordinates' do
    it 'is not valid' do
      station_form = build :station_form, :with_coords

      expect(station_form).to be_invalid
    end
  end

  describe '#save' do
    it 'should return a truthy value if the records were saved' do
      station_form = build :station_form

      expect(station_form.save).to be_truthy
    end

    it 'should return a falsy value if the records were not saved' do
      station_form = build :station_form, :invalid

      expect(station_form.save).to be_falsey
    end

    context 'when the station record is invalid' do
      it 'does not start a GeocodeJob', :with_active_job_test_adapter do
        station_form = build :station_form, name: nil

        station_form.save

        expect(GeocodeJob).to_not have_been_enqueued
      end
    end
  end
end
