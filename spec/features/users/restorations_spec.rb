require 'rails_helper'

RSpec.feature 'User account restoration', type: :feature do
  scenario 'User initiates account restoration', :js do
    skip 'not implemented yet'
    user = create :user, :soft_deleted
    visit welcome_index_path

    click_on 'Restore account'
    fill_in 'Email', with: user.email
    click_on 'Restore'

    expect(page).to have_content 'Glad to have you back! We\'ve sent account '\
                                 'restoration instructions to your email.'
    expect(emails).to have(1).email
  end

  scenario 'User completes account restoration' do
    skip 'not implemented yet'
    user = create :user, :soft_deleted
    post user_restore_path, email: user.email

    email = ActionMailer::Base.deliveries.last
    visit email.body.find('.create_restoration')

    expect(page).to flash_message 'Your account has been successfully restored'
    expect(user).to be_signed_in
  end
end
