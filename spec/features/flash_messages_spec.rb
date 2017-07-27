require 'rails_helper'

RSpec.describe 'Flash messages' do
  scenario 'Anyone triggers flash message to appear, and then dimisses it',
           :js do
    visit root_path

    welcome_page.open_log_in_form
    log_in_form.submit
    flash.dismiss

    expect(page).to_not show :flash
  end
end
