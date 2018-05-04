require 'rails_helper'

RSpec.describe 'User logs deed', type: :feature do
  scenario 'from dashboard' do
    create_and_login_user follow_to_default_path: true

    dashboard.log_deed
    deed_form.trash_bags = 3
    deed_form.submit

    expect(page).to flash_message t('deeds.create.success')
    expect(dashboard.total_points).to eq 3
  end

  scenario 'with 0 trash bags' do
    create_and_login_user follow_to_default_path: true

    dashboard.log_deed
    deed_form.trash_bags = 0
    deed_form.submit

    expect(deed_form).to show_errors \
      including: t('activerecord.errors.models.deed.nothing_was_done')
  end

  scenario 'more than 30 points' do
    create_and_login_user follow_to_default_path: true

    dashboard.log_deed
    deed_form.trash_bags = 50
    deed_form.submit

    expect(deed_form).to show_errors \
      including: t('activerecord.errors.models.deed.maximum_points')
  end

  scenario 'first 20 points, then 12' do
    create_and_login_user follow_to_default_path: true

    dashboard.log_deed
    deed_form.trash_bags = 20
    deed_form.submit

    expect(page).to flash_message t('deeds.create.success')
    expect(dashboard.total_points).to eq 20

    dashboard.log_deed
    deed_form.trash_bags = 12
    deed_form.submit

    expect(page).to flash_message t('deeds.create.fail_multiple',
                                    p_left_total: 2)
    expect(dashboard.total_points).to eq 30
  end
end
