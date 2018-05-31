require 'rails_helper'

RSpec.describe 'User Sessions', type: :feature do
  scenario 'User signs in', :js do
    user = create :user

    visit root_path
    welcome_page.open_log_in_form
    log_in_form.fill_and_submit_for user

    expect(page).to flash_message t('users.sessions.signed_in')
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

    expect(page).to flash_message t('devise.failure.user.account_deleted')
    expect(page).to_not show :dashboard
  end

  scenario 'A user with 3 or more strikes cannot sign in' do
    user = create :user
    create_list :strike, 3, user: user

    visit root_path
    welcome_page.open_log_in_form
    log_in_form.fill_and_submit_for user

    expect(page).to flash_message t('devise.failure.user.deactivated_by_admin')
  end

  scenario 'A logged in user is logged out when they get a third strike' do
    user = create :user
    stubbed_login_as user

    visit root_path
    create_list :strike, 3, user: user
    dashboard.log_deed

    expect(page).to_not show :dashboard
  end

  # js enabled b/c error only shows in this case
  scenario 'User signs out from welcome page', :js do
    create_and_login_user

    visit welcome_index_path
    app_bar.open_drawer
    nav_drawer.sign_out

    expect(page).to flash_message t('users.sessions.signed_out')
    expect(page).to show :welcome_page
  end

  scenario 'User log in fails', :js do
    skip 'Not sure what is going on here. The turoblinks cache seems to always'\
         ' be using an outdated version of the page. To see this, try opening '\
         'the login form, filling in an email address and hitting submit. Then'\
         ' hit the browser back button, open the log in form and hit submit. '\
         ' Continue this, alternating whether or no you fill in the email '\
         'field an you will see what I mean.'
    user = create :user

    visit root_path
    welcome_page.open_log_in_form
    log_in_form.email = user.email
    log_in_form.submit
    click_browser_back_button

    expect(page).to show :log_in_form
    expect(log_in_form.email).to have_text user.email
  end
end
