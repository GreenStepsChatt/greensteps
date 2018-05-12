require 'rails_helper'

RSpec.describe Admins::StationsController, type: :controller do
  let(:station) { create(:station) }
  let(:address) { create(:address) }

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

  describe 'PUT #update' do
    context 'invalid station' do
      it 're-renders the form' do
        sign_in create(:admin)
        station = create(:station)
        station.address = address

        put :update, params: { station: { name: station.name }, address: { street: '', city: address.city, state: address.state, zip: address.zip }, latitude: '', longitude: '', commit: 'Save', id: station.id }

        expect(response).to render_template(:edit)
      end
    end
  end
end
