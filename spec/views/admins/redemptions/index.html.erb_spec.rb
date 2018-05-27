require 'rails_helper'

RSpec.describe 'admins/redemptions/index' do
  before(:each) do
    render template: 'admins/redemptions/index', locals: {
      redemptions: create_list(:redemption, 2)
    }
  end

  it { should require_field '#redemption_confirmation_number' }
end
