require 'rails_helper'

RSpec.describe Address, of_type: :model do
  subject { build :address }
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
  it { should allow_value('CA').for(:state) }
  it { should_not allow_value('01').for(:state) }
  it { should_not allow_value('.a').for(:state) }
  it { should allow_value('31088').for(:zip) }
  it { should allow_value('31088-1010').for(:zip) }
  it { should_not allow_value('310-881010').for(:zip) }
  it { should_not allow_value('31088-10').for(:zip) }
  it { should_not allow_value('31088--1010').for(:zip) }
  it { should_not allow_value('abcdef').for(:zip) }
  it { should_not allow_value('100.00').for(:zip) }
end
