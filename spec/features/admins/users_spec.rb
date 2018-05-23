require 'rails_helper'

RSpec.describe 'Admin\'s list of users', type: :feature do
  scenario 'The list is paginated, with 25 users per page' do
    create_and_login_admin
    users = create_list :user, 30

    visit admins_users_path

    expect(page).to have_selector '.user', count: 25
    expect(page).to have_selector '.pagination'
  end
end
