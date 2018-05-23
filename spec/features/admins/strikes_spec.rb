require 'rails_helper'

RSpec.describe 'Three strikes and you\'re out', type: :feature do
  scenario 'Admin views a list of all users and adds a strike to one of them' do
    users = create_list :user, 3
    bad_user = users.first
    create_and_login_admin

    visit admins_users_path
    user_list.strike(bad_user)

    expect(page).to flash_message \
      t('admins.strikes.create.success', user_email: bad_user.email)
    expect(user_list.list_item_for(bad_user)).to have_one_strike
  end
end
