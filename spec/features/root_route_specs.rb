require 'rails_helper'

RSpec.describe 'Root route for various situations', type: :feature do
  scenario 'for an admin, the root route shows the admin dashboard' do
    create_and_login_admin

    visit root_path

    expect(page).to show :admin_dashboard
  end

  scenario 'for a regular user, the root route shows the regular dashboard' do
    create_and_login_user

    visit root_path

    expect(page).to show :dashboard
  end

  scenario 'for a visitor, the root route shows the welcome page' do
    visit root_path

    expect(page).to show :welcome_page
  end
end
