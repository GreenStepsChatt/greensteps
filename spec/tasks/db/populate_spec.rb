require 'rails_helper'

RSpec.describe 'rake db:populate', type: :task do
  it 'preloads the Rails environment' do
    expect(task.prerequisites).to include 'environment'
  end

  it 'adds 50 users to the database' do
    task.execute

    expect(User.count).to eq 50
  end
end
