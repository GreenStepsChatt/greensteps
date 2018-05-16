require 'rails_helper'
require Rails.root.join('lib', 'add_points_to_user.rb')

RSpec.describe AddPointsToUser do
  let(:user) { create :user }

  it 'correctly adds 1 point' do
    AddPointsToUser.new(user, 1)

    expect(user.total_points).to eq 1
  end

  it 'correctly adds 2 point' do
    AddPointsToUser.new(user, 2)

    expect(user.total_points).to eq 2
  end

  it 'correctly adds 8 point' do
    AddPointsToUser.new(user, 8)

    expect(user.total_points).to eq 8
  end

  it 'does nothing if total_points is nil' do
    AddPointsToUser.new(user, nil)

    expect(user.total_points).to eq 0
  end

  it 'does nothing if total_points is 0' do
    AddPointsToUser.new(user, 0)

    expect(user.total_points).to eq 0
  end
end
