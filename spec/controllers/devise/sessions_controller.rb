require 'rails_helper'

RSpec.describe Devise::SessionsController, type: :controller do
  before(:each) { @request.env['devise.mapping'] = Devise.mappings[:user] }

  describe 'POST #create' do
    it 'should not check if user is soft deleted when a regular user is '\
       'signing in' do
      user = create :user

      expect(User).to_not receive :only_deleted
      expect(User).to_not receive :with_deleted

      post :create, params: {
        user: { email: user.email, password: user.password }
      }
    end
  end
end
