require 'rails_helper'

RSpec.describe Admins::AdminsController, type: :controller do
  describe 'POST #create' do
    context 'invalid admin' do
      it 're-renders the form' do
        sign_in create(:admin)

        post :create, params: { admin: { email: 'not_in_db@example.com' } }

        expect(response).to render_template(:new)
      end
    end
  end

  context 'non-admin user' do
    [
      %i[get index],
      %i[get new],
      %i[post create]
    ].each do |method, action|
      include_examples 'restricted to admins html response', method, action
    end

    include_examples('restricted to admins ajax response', :delete, :destroy) do
      let(:params) { { id: create(:admin) } }
    end
  end
end
