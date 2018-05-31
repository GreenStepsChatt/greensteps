require 'rails_helper'

RSpec.describe 'users/registrations/_form' do
  before(:each) do
    render 'users/registrations/form'
  end

  it do
    should have_content t('users.shared.terms.message_html',
                          link: t('users.shared.terms.link_text'))
  end
end
