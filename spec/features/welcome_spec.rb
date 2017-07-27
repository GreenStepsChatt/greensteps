require 'rails_helper'

RSpec.feature "Welcome", type: :feature do
  scenario 'Visitor lands on welcome page' do
    visit root_path

    expect(page).to have_content t('welcome.index.greeting')
  end
end
