require 'rails_helper'

RSpec.feature 'User logs trash bag', type: :feature do
  scenario 'from dashboard' do
    create_and_login_user

    dashboard.add_trash_bag

    expect(page).to flash_message t('trash_bags.create.success')
    expect(dashboard.trash_bag_count).to eq '1'
  end
end
