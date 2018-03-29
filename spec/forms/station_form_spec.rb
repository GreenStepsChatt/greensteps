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
      expect(CoordinatePair).to exist latitude: 35.042039, longitude: -85.283085
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
      expect(Address).to exist street: '101 Main Street'
    end
  end

  it 'should return a truthy value if the records were saved successfully' do
    station_form = build :station_form

    expect(station_form.save).to be_truthy
  end

  it 'should return a falsy value if the records were not saved successfully' do
    station_form = build :station_form, :invalid

    expect(station_form.save).to be_falsey
  end
end
