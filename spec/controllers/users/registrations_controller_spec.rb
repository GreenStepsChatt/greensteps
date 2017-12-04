require 'rails_helper'

RSpec.describe Users::RegistrationsController, :devise, type: :controller do
  describe 'POST #create' do
    context 'for a soft deleted user' do
      it 'redirects back' do
        user = create :user, :soft_deleted
        request.env['HTTP_REFERER'] = 'where_i_came_from'

        post :create, params: {
          user: {
            email: user.email,
            password: user.password,
            password_confirmation: user.password
          }
        }

        expect(response).to redirect_to 'where_i_came_from'
      end
    end
  end
end
