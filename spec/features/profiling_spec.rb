require 'rails_helper'

RSpec.describe 'MiniProfiler', type: :feature do
  it 'runs for a user with the developer role' do
    create_and_login_developer

    visit root_path

    expect(Rack::MiniProfiler.request_authorized?).to be_truthy
  end

  it 'does not run for a regular user' do
    skip 'this test fails intermittently :( (maybe related to '\
         'MiniProfiler/rack-mini-profiler/issues/260)'
    create_and_login_user

    visit root_path

    expect(Rack::MiniProfiler.request_authorized?).to be_falsey
  end
end
