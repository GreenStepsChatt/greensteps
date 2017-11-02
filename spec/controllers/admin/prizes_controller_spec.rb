require 'rails_helper'

RSpec.describe Admin::PrizesController, type: :controller do
  it_should_behave_like 'an admin controller'

  describe 'POST #create' do
    context 'invalid prize' do
      it 're-renders the form' do
        sign_in create(:admin)

        post :create, params: { prize: attributes_for(:prize, :invalid) }

        expect(response).to render_template(:new)
      end
    end
  end
end
