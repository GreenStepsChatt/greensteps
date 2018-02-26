require 'rails_helper'

RSpec.describe Admins::StationsController, type: :controller do
  describe 'POST #create' do
    context 'invalid station form' do
      it 're-renders the form' do
        sign_in create(:admin)

        post :create, params: {
          station_form: attributes_for(:station_form, :invalid)
        }

        expect(response).to render_template(:new)
      end
    end
  end
end
