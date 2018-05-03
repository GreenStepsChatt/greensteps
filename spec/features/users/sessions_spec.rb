require 'rails_helper'

RSpec.describe 'User Sessions', type: :feature do
  scenario 'User signs in', :js do
    user = create :user

    visit root_path
    welcome_page.open_log_in_form
    log_in_form.fill_and_submit_for user

    expect(page).to flash_message t('devise.sessions.signed_in')
    expect(page).to show :dashboard
  end

  scenario 'Admin signs in' do
    admin = create :admin

    visit root_path
    welcome_page.open_log_in_form
    log_in_form.fill_and_submit_for admin

    expect(page).to show :admin_dashboard
  end

  scenario 'User cannot login after deleting their account' do
    user = create :user, :soft_deleted

    visit root_path
    welcome_page.open_log_in_form
    log_in_form.fill_and_submit_for user

    expect(page).to flash_message t('devise.sessions.account_deleted')
    expect(page).to_not show :dashboard
  end

  # js enabled b/c error only shows in this case
  scenario 'User signs out from welcome page', :js do
    create_and_login_user

    visit welcome_index_path
    app_bar.open_drawer
    nav_drawer.sign_out

    expect(page).to flash_message t('devise.sessions.signed_out')
    expect(page).to show :welcome_page
  end
end
