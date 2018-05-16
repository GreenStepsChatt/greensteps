require 'rails_helper'

RSpec.describe 'rake db:repopulate', type: :task do
  it 'resets the database and then poplates it' do
    expect(task.prerequisites).to include 'reset', 'populate'
  end
end
