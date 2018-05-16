require 'rails_helper'

RSpec.describe 'rake db:populate', type: :task do
  before(:all) do
    Swapper.while('Delayed::Worker')
           .has(:delay_jobs).set_to(false) { Rake::Task['db:populate'].execute }
  end

  after(:all) do
    reset_db_with_database_cleaner
  end

  it 'preloads the Rails environment' do
    expect(task.prerequisites).to include 'environment'
  end

  it 'adds 50 users to the database' do
    expect(User.without_role(:admin)).to have(50).records
  end

  it 'adds 3 admins to the database' do
    expect(User.with_role(:admin)).to have(3).records
  end

  it 'confirms the first 5 users (at least)' do
    expect(User.first(5)).to all(be_confirmed)
  end

  it 'adds 5 prizes to the database' do
    expect(Prize).to have(5).records
  end

  it 'creates a variety prize titles' do
    expect(Prize.distinct.pluck(:title)).to have(5).unique_titles
  end

  it 'creates a random number of deeds for some user' do
    expect(Deed.count).to be > 0
  end

  it 'creates one station with a street address' do
    expect(Station.joins(:address).count).to eq 1
  end

  it 'geocodes addresses' do
    expect(Address.joins(:coordinate_pair).count).to be > 0
  end

  it 'creates five stations with coordinates' do
    expect(Station.joins(:coordinate_pair).count).to eq 5
  end
end
