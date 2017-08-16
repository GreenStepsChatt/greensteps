require 'rails_helper'

RSpec.feature 'Dashboard', type: :feature do
  scenario 'Guests are asked to log in first' do
    visit dashboards_show_path

    alert_message = 'You must be logged in to access this page'
    expect(current_path).to eq(root_path)
    expect(page).to have_content(alert_message)
  end
end
