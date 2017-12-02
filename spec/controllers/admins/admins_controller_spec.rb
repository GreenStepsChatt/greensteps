require 'rails_helper'

RSpec.describe Admins::AdminsController, type: :controller do
  it_should_behave_like 'an admin controller'

  describe 'POST #create' do
    context 'invalid admin' do
      it 're-renders the form' do
        sign_in create(:admin)

        post :create, params: { admin: { email: 'not_in_db@example.com' } }

        expect(response).to render_template(:new)
      end
    end
  end
end
