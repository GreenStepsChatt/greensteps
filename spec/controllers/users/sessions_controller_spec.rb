require 'rails_helper'

RSpec.describe Devise::SessionsController, :devise, type: :controller do
  describe 'POST #create' do
    it 'should not check if user is soft deleted when a regular user is '\
       'signing in' do
      user = create :user

      expect(User).to_not receive :soft_deleted
      expect(User).to_not receive :soft_deleted

      post :create, params: {
        user: { email: user.email, password: user.password }
      }
    end
  end
end
