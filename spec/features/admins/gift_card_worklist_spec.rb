require 'rails_helper'

RSpec.describe 'Admin gift card work list', type: :feature do
  scenario 'Admin views the work list and sees gift card requests' do
    user = create :user, total_points: 10
    redemptions = create_list :redemption, 2, user: user, value: 5
    create_and_login_admin

    visit admins_redemptions_path

    expect(work_list).to include redemptions
  end

  scenario 'Admin views the work list and does not see fulfilled requests' do
    user = create :user, total_points: 10
    redemption = create :redemption, :fulfilled, user: user, value: 5
    create_and_login_admin

    visit admins_redemptions_path

    expect(work_list).to have_no_row_with redemption
  end

  scenario 'Admin marks gift card request as completed', :js do
    user = create :user, total_points: 5
    redemption = create :redemption, user: user, value: 5
    create_and_login_admin

    visit admins_redemptions_path
    work_list.fulfill(redemption, 'xx11-BA')

    expect(page).to flash_message t('admins.redemptions.update.success')
    expect(work_list).to have_no_row_with redemption
  end
end
