require 'rails_helper'

RSpec.describe 'Dashboard', type: :feature do
  scenario 'Guests are asked to log in first' do
    visit dashboards_show_path

    expect(page).to show :welcome_page
    expect(page).to flash_message t('no_visitor_access')
  end
end
