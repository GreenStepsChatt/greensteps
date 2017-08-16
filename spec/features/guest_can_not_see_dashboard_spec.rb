require 'rails_helper'

RSpec.feature 'Dashboard', type: :feature do
  scenario 'Guests are asked to log in first' do
    visit dashboards_show_path

    expect(current_path).to eq(root_path)
    expect(page).to flash_message t('not_logged_in')
  end
end
