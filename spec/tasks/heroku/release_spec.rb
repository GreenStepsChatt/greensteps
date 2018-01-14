require 'rails_helper'

RSpec.describe 'rake heroku:release', type: :task do
  it 'loads schema if it is not already defined' do
    stub_after_party
    allow(ActiveRecord::Migrator).to receive(:current_version).and_return(0)
    expect(Rake::Task['db:schema:load']).to receive(:invoke)
    task.execute
  end

  it 'runs migrations if db schema exists' do
    stub_after_party
    expect(Rake::Task['db:migrate']).to receive(:invoke)
    task.execute
  end

  it 'runs after party tasks' do
    expect(Rake::Task['after_party:run']).to receive(:invoke)
    task.execute
  end

  def stub_after_party
    allow(Rake::Task['after_party:run']).to receive(:invoke)
  end
end
