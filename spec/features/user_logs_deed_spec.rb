require 'rails_helper'

RSpec.feature 'User logs deed', type: :feature do
  scenario 'from dashboard' do
    create_and_login_user

    dashboard.log_deed
    deed_form.trash_bags = 1
    deed_form.miles_walked = 2
    deed_form.submit

    expect(page).to flash_message t('deeds.create.success')
    expect(dashboard.trash_bag_count).to eq 1
    expect(dashboard.miles_walked).to eq 2
  end
end
