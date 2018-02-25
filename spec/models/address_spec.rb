require 'rails_helper'

RSpec.describe Address, of_type: :model do
  it { should have_db_column(:street).of_type(:string) }
  it { should have_db_column(:city).of_type(:string) }
  it { should have_db_column(:state).of_type(:string) }
  it { should have_db_column(:zip).of_type(:string) }
  it { should have_db_column(:addressable_id).of_type(:integer) }
  it { should have_db_column(:addressable_type).of_type(:string) }
  it { should belong_to(:addressable) }
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_length_of(:state).is_equal_to(2) }
  it { should validate_presence_of(:zip) }
  it { should validate_length_of(:zip).is_at_least(5) }
end
