require 'rails_helper'

RSpec.describe 'rake db:populate', type: :task do
  before(:all) do
    Swapper.while('Delayed::Worker')
           .has(:delay_jobs).set_to(false) { Rake::Task['db:populate'].execute }
  end

  after(:all) do
    reset_db_with_database_cleaner
  end

  describe 'sample users' do
    it 'there are 50 total' do
      expect(User.without_role(:admin)).to have(50).records
    end

    it '3 are admins' do
      expect(User.with_role(:admin)).to have(3).records
    end

    it 'the first 5 are confirmed (at least)' do
      expect(User.first(5)).to all(be_confirmed)
    end

    it 'the first 5 have enough points to redeem prizes' do
      expect(User.first(5).map(&:total_points)).to all(be >= 10)
    end

    it 'the first 3 users have redeemed one prize each' do
      expect(User.first(3).map(&:prizes).map(&:count)).to all(eq 1)
    end
  end

  it 'preloads the Rails environment' do
    expect(task.prerequisites).to include 'environment'
  end

  it 'adds at least 5 prizes to the database' do
    expect(Prize).to have_at_least(5).records
  end

  it 'creates a variety prize titles' do
    expect(Prize.distinct.pluck(:title)).to have(5).unique_titles
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
