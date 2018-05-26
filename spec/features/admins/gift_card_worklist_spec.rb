require 'rails_helper'

RSpec.describe 'Admin gift card work list', type: :feature do
  scenario 'Admin views the work list and sees gift card requests' do
    user = create :user, total_points: 10
    redemptions = create_list :redemption, 2, user: user, value: 5
    create_and_login_admin

    visit admins_redemptions_path

    expect(work_list).to include redemptions
  end
end
