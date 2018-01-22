require 'rails_helper'

RSpec.describe 'User email confirmation', type: :feature do
  scenario 'User can log in during the grace period without
    confirming email', :js do
    new_user_info = build_stubbed :user

    visit root_path
    sign_up_form.fill_and_submit_with new_user_info

    expect(page).to flash_message t('devise.registrations.signed_up')
    expect(User).to exist email: new_user_info.email
    expect(page).to_not show :sign_up_form
    expect(page).to_not show :log_in_form
  end

  scenario 'User is sent confirmation email when they register', :focus do
    new_user_info = build_stubbed :user

    visit root_path
    sign_up_form.fill_and_submit_with new_user_info

    expect(last_email.subject).to eq 'Confirmation instructions'
    expect(last_email.to).to eq [new_user_info.email]
  end

  scenario 'User has not confirmed their account and grace period ended', :js do
    user = create :user
    user.update(confirmation_sent_at: 3.days.ago)

    visit root_path
    welcome_page.open_log_in_form
    log_in_form.fill_and_submit_for user

    expect(page).to flash_message t('devise.failure.unconfirmed')
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'User confirms their account within grace period', :js do
    user = create :user

    visit user_confirmation_path(confirmation_token: user.confirmation_token)

    expect(page).to flash_message t('devise.confirmations.confirmed')
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'User tries to confirm their account after grace period', :js do
    user = create :user
    user.update(confirmation_sent_at: 3.days.ago)

    visit user_confirmation_path(confirmation_token: user.confirmation_token)

    expect(page).to show_errors t('errors.messages.confirmation_period_expired')
  end

  scenario 'User tries to confirm an already confirmed account', :js do
    user = create :user

    visit user_confirmation_path(confirmation_token: user.confirmation_token)
    visit user_confirmation_path(confirmation_token: user.confirmation_token)

    expect(page).to show_errors t('errors.messages.already_confirmed')
  end
end
