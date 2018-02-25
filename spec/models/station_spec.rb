require 'rails_helper'

RSpec.describe Station, type: :model do
  it { should have_db_column(:name).of_type(:string) }
  it { should have_one(:address) }
  it { should validate_presence_of(:name) }
end
