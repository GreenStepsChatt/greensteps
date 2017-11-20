require 'rails_helper'

RSpec.feature 'User Registrations:', type: :feature do
  scenario 'Visitor signs up', :js do
    new_user_info = build_stubbed :user

    visit root_path
    sign_up_form.fill_and_submit_with new_user_info

    expect(page).to flash_message t('devise.registrations.signed_up')
    expect(User).to exist email: new_user_info.email
    expect(page).to_not show :sign_up_form
    expect(page).to_not show :log_in_form
  end

  scenario 'User changes password', :js do
    user = create :user, password: 'old_password'
    stubbed_login_as user

    appbar.open_drawer
    nav_drawer.edit_account_settings
    account_settings_form.change_password(user.password, 'new_password')

    expect(user).to have_password 'new_password'
    expect(page).to flash_message t('devise.registrations.updated')
  end

  scenario 'User deletes their account', :js do
    user = create :user
    stubbed_login_as user

    appbar.open_drawer
    nav_drawer.edit_account_settings
    delete_account

    expect(page).to flash_message t('devise.registrations.destroyed')
    expect(User).to_not exist email: user.email
    expect(User.with_deleted).to exist email: user.email
  end

  def delete_account
    accept_confirm do
      click_on 'Cancel my account'
    end
  end
end

RSpec::Matchers.define :have_password do |expected_password|
  match do |user|
    user.reload.valid_password? expected_password
  end
end
