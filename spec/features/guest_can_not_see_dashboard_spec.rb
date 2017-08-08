require 'rails_helper'

RSpec.describe 'As a guest' do
  scenario 'Cannot access dashboard page',
           :js do
    visit dashboards_show_path

    alert_message = 'You must be logged in to access this page'
    expect(current_path).to eq(root_path)
    expect(page).to have_content(alert_message)
  end
end
