require 'rails_helper'

RSpec.describe 'Admins can view a list of users', type: :feature do
  it 'is paginated with 25 users per page' do
    create_and_login_admin
    create_list :user, 30

    visit admins_users_path

    expect(page).to have_selector '.user', count: 25
    expect(page).to have_selector '.pagination'
  end

  it 'is sorted by total points, in descending order, by default' do
    create_list :user, 3
    user = create :user, total_points: 3
    create_and_login_admin

    visit admins_users_path

    expect(user_list.first_user_li).to be_for user
  end

  it 'can be sorted by email' do
    create_list :user, 3
    user = create :user, email: 'aaa@example.com'
    create_and_login_admin

    visit admins_users_path
    click_on t('admins.users.index.email')

    expect(user_list.first_user_li).to be_for user
  end

  scenario 'Admin clicks on the email header, then the total points header' do
    create_list :user, 3
    user = create :user, total_points: 3
    create_and_login_admin

    visit admins_users_path
    click_on t('admins.users.index.email')
    click_on t('admins.users.index.total_points')

    expect(user_list.first_user_li).to be_for user
  end

  it 'can have the sort order reversed' do
    admin = create(:admin, total_points: 3)
    create_list :user, 3, total_points: 5
    stubbed_login_as admin

    visit admins_users_path
    click_on t('admins.users.index.total_points')

    expect(user_list.first_user_li).to be_for admin
  end
end
