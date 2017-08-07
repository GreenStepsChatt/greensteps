require 'rails_helper'

RSpec.feature 'As a guest', type: :feature do
  scenario 'cannot access dashboard page' do
    visit dashboards_show_path

    alert_message = 'You must be logged in to access this page.'
    expect(current_path).to eq(root_path)
    expect(page).to have_content(alert_message)
  end
end
