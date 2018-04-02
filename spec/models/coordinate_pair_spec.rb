require 'rails_helper'

RSpec.describe CoordinatePair, type: :model do
  subject { build_stubbed :coordinate_pair }

  it do
    should have_db_column(:latitude).of_type(:float).with_options(null: false)
  end
  it do
    should have_db_column(:longitude).of_type(:float).with_options(null: false)
  end
  it { should have_db_column(:locateable_id).of_type(:integer) }
  it { should have_db_column(:locateable_type).of_type(:string) }

  it { should belong_to(:locateable) }

  it { should validate_presence_of(:latitude) }
  it { should_not allow_value(-100).for(:latitude) }
  it { should_not allow_value(100).for(:latitude) }

  it { should validate_presence_of(:longitude) }
  it { should_not allow_value(-200).for(:longitude) }
  it { should_not allow_value(200).for(:longitude) }
end
