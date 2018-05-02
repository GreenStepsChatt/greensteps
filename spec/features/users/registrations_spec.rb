require 'rails_helper'

RSpec.describe 'User Registrations', type: :feature do
  scenario 'Visitor signs up', :js, :with_active_job_test_adapter do
    new_user_info = attributes_for :user

    visit root_path
    sign_up_form.fill_and_submit_with new_user_info

    expect(page).to flash_message t('users.registrations.signed_up')
    expect(ActionMailer::DeliveryJob).to have_been_enqueued
    expect(User).to include_record_with email: new_user_info[:email]
    expect(page).to_not show :sign_up_form
    expect(page).to_not show :log_in_form
  end

  scenario 'User changes password', :js do
    user = create :user, password: 'old_password'
    stubbed_login_as user

    visit edit_user_registration_path
    account_settings_form.change_password(user.password, 'new_password')

    expect(user).to have_password 'new_password'
    expect(page).to flash_message t('users.registrations.updated')
  end

  scenario 'User deletes their account', :js do
    user = create :user
    stubbed_login_as user

    visit edit_user_registration_path
    delete_account

    expect(User).to_not exist email: user.email
    expect(User.only_deleted).to include_record_with email: user.email
    expect(page).to flash_message t('users.registrations.destroyed')
  end

  scenario 'Soft-deleted user tries to re-register with same email' do
    user = create :user, :soft_deleted

    visit root_path
    sign_up_form.email = user.email
    sign_up_form.password = user.password
    sign_up_form.submit

    expect(flash).to have_content \
      t('users.registrations.create.account_deleted')
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
