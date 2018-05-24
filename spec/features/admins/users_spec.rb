require 'rails_helper'

RSpec.describe 'Admin\'s list of users', type: :feature do
  scenario 'The list is paginated, with 25 users per page' do
    create_and_login_admin
    users = create_list :user, 30

    visit admins_users_path

    expect(page).to have_selector '.user', count: 25
    expect(page).to have_selector '.pagination'
  end

  scenario 'By default, the list is sorted by total points (desc)' do
    create_list :user, 3
    user = create :user, total_points: 3
    create_and_login_admin

    visit admins_users_path

    expect(user_list.first_user_li.id).to eq user.id
  end

  scenario 'It can be sorted by email' do
    create_list :user, 3
    user = create :user, email: 'aaa@example.com'
    create_and_login_admin

    visit admins_users_path
    click_on 'Email'

    expect(user_list.first_user_li.id).to eq user.id
  end
end
