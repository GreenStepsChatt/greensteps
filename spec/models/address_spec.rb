require 'rails_helper'

RSpec.describe Address, of_type: :model do
  it { should have_db_column(:street).of_type(:string) }
  it { should have_db_column(:city).of_type(:string) }
  it { should have_db_column(:state).of_type(:string) }
  it { should have_db_column(:zip).of_type(:integer) }
  it { should have_db_column(:addressable_id).of_type(:integer) }
  it { should have_db_column(:addressable_type).of_type(:string) }
  it { should belong_to(:addressable) }
end
