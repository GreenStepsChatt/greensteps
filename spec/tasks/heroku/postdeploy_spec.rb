require 'rails_helper'

RSpec.describe 'rake heroku:postdeploy', type: :task do
  it 'seeds the database' do
    expect(task.prerequisites).to include 'db:seed'
  end

  it 'populates the database if `USE_SAMPLE_DATA` is true' do
    allow(ENV).to receive('[]').with('USE_SAMPLE_DATA').and_return(true)
    expect(Rake::Task['db:populate']).to receive(:invoke)
    task.execute
  end

  it 'does not populates the database if `USE_SAMPLE_DATA` is false or nil' do
    allow(ENV).to receive('[]').with('USE_SAMPLE_DATA').and_return(false)
    expect(Rake::Task['db:populate']).to_not receive(:invoke)
    task.execute
  end
end
