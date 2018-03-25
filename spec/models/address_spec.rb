require 'rails_helper'

RSpec.describe Address, of_type: :model do
  subject { build :address }

  # Database
  it { should have_db_column(:street).of_type(:string) }
  it { should have_db_column(:city).of_type(:string) }
  it { should have_db_column(:state).of_type(:string) }
  it { should have_db_column(:zip).of_type(:string) }
  it { should have_db_column(:addressable_id).of_type(:integer) }
  it { should have_db_column(:addressable_type).of_type(:string) }
  it { should have_db_column(:latitude).of_type(:float) }
  it { should have_db_column(:longitude).of_type(:float) }

  # Associations
  it { should belong_to(:addressable) }

  # Validations
  it { should validate_length_of(:state).is_equal_to(2) }
  it { should allow_value(nil).for(:state) }
  it { should allow_value('CA').for(:state) }
  it { should_not allow_value('01').for(:state) }
  it { should_not allow_value('.a').for(:state) }

  it { should allow_value(nil).for(:zip) }
  it { should allow_value('31088').for(:zip) }
  it { should allow_value('31088-1010').for(:zip) }
  it { should_not allow_value('310-881010').for(:zip) }
  it { should_not allow_value('31088-10').for(:zip) }
  it { should_not allow_value('31088--1010').for(:zip) }
  it { should_not allow_value('abcdef').for(:zip) }
  it { should_not allow_value('100.00').for(:zip) }

  it 'should be valid with just a set of coordinates' do
    address = build :address, :no_street_address, latitude: 0, longitude: 0

    expect(address).to be_valid
  end

  it 'should be invalid if both a street address and coordinates are missing' do
    address = build :address, :no_street_address, :no_coordinates

    expect(address).to be_invalid
  end

  it 'needs both coordinates if street address is missing' do
    address = build :address, :no_street_address, latitude: 0, longitude: nil

    expect(address).to be_invalid
  end

  it 'needs a street if coordinates are misisng' do
    address = build :address, :no_coordinates, street: nil

    expect(address).to be_invalid
  end

  it 'needs either a zip or a city and state if coordinates are misisng' do
    address = build :address, :no_coordinates, city: nil, state: nil, zip: nil

    expect(address).to be_invalid
  end
end
