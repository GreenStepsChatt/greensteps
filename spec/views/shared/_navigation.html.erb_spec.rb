require 'rails_helper'

RSpec.describe 'shared/_navigation' do
  context 'for a logged in user' do
    before(:each) do
      sign_in create(:user)
      render template: 'shared/_navigation'
    end

    it { should_not have_link t('shared.navigation.user_dashboard') }
  end

  context 'for a logged in admin' do
    before(:each) do
      sign_in create(:admin)
      render template: 'shared/_navigation'
    end

    it { should have_link t('shared.navigation.user_dashboard') }
  end
end
