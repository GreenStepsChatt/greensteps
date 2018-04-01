require 'rails_helper'

RSpec.describe Address, of_type: :model do
  subject { build_stubbed :address }

  # Database
  it do
    should have_db_column(:street).of_type(:string).with_options(null: false)
  end
  it { should have_db_column(:city).of_type(:string).with_options(null: false) }
  it do
    should have_db_column(:state).of_type(:string).with_options(null: false)
  end
  it { should have_db_column(:zip).of_type(:string).with_options(null: false) }
  it { should have_db_column(:addressable_id).of_type(:integer) }
  it { should have_db_column(:addressable_type).of_type(:string) }

  # Associations
  it { should belong_to(:addressable) }
  it { should have_one(:coordinate_pair) }

  # Validations
  it { should validate_presence_of(:street) }

  it { should validate_presence_of(:city) }

  it { should validate_presence_of(:state) }
  it { should validate_length_of(:state).is_equal_to(2) }
  it { should allow_value('CA').for(:state) }
  it { should_not allow_value('01').for(:state) }
  it { should_not allow_value('.a').for(:state) }

  it { should validate_presence_of(:zip) }
  it { should allow_value('31088').for(:zip) }
  it { should allow_value('31088-1010').for(:zip) }
  it { should_not allow_value('310-881010').for(:zip) }
  it { should_not allow_value('31088-10').for(:zip) }
  it { should_not allow_value('31088--1010').for(:zip) }
  it { should_not allow_value('abcdef').for(:zip) }
  it { should_not allow_value('100.00').for(:zip) }

  # Helper Methods
  describe '#to_sentence' do
    it 'should build a sentence using the attributes' do
      address = build_stubbed :address,
                              street: '101 Main Street',
                              city: 'Warner Robins', state: 'GA', zip: '31088'

      expect(address.to_sentence).to eq \
        '101 Main Street, Warner Robins, GA 31088'
    end
  end

  describe '#coordinate_pair_stale' do
    it 'is true if any of VALUE_ATTRIBUTES changed in previous save' do
      address = create :address, :with_coordinate_pair
      address.street = '999 New Street'
      address.save

      expect(address.coordinate_pair_stale?).to be_truthy
    end

    it 'is false if none of VALUE_ATTRIBUTES were changed in previous save' do
      address = create :address, :with_coordinate_pair
      address.addressable = create :station
      address.save

      expect(address.coordinate_pair_stale?).to be_falsey
    end

    it 'is false if the coordinate pair is blank' do
      address = create :address
      address.save

      expect(address.coordinate_pair_stale?).to be_truthy
    end
  end
end
