require 'rails_helper'

RSpec.describe 'User account soft deletion', type: :feature do
  scenario 'User cannot login after deleting their account' do
    user = create :user, :soft_deleted

    visit root_path
    welcome_page.open_log_in_form
    log_in_form.fill_and_submit_for user

    expect(page).to flash_message /cannot login.*deleted/
    expect(page).to_not show :dashboard
  end
end
