require 'rails_helper'

RSpec.describe 'User account soft deletion', type: :feature do
  scenario 'User cannot login after deleting their account' do
    user = create :user, :soft_deleted

    visit root_path
    welcome_page.open_log_in_form
    log_in_form.fill_and_submit_for user

    expect(page).to flash_message(/cannot login.*deleted/)
    # expect(flash).to have_link 'restore your account' # TODO: implement this
    expect(page).to_not show :dashboard
  end

  scenario 'Soft-deleted user tries to re-register with same email' do
    user = create :user, :soft_deleted

    visit root_path
    sign_up_form.fill_and_submit_with user

    expect(flash).to have_content \
      t('users.registrations.create.account_deleted')
    # expect(flash).to have_link 'restore account' # TODO: implement this
  end
end
