require 'rails_helper'

RSpec.describe DeedsController, type: :controller do
  describe 'POST #create' do
    context 'invalid deed' do
      it 're-renders the form' do
        sign_in create(:user)

        post :create, params: { deed: attributes_for(:deed, :invalid) }

        expect(response).to render_template(:new)
      end
    end
  end
end
