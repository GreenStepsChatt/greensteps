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

  describe 'GET edit' do
    it 'returns http success' do
      sign_in create(:admin)
      get :edit, params: { id: station.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the #edit view' do
      sign_in create(:admin)
      get :edit, params: { id: station.id }
      expect(response).to render_template :edit
    end

    it 'assigns station to be updated to @station' do
      sign_in create(:admin)
      station.address = address
      get :edit, params: { id: station.id }
      station_instance = assigns(:station)
      expect(station_instance.id).to eq station.id
      expect(station_instance.name).to eq station.name
      expect(station_instance.address.street).to eq address.street
      expect(station_instance.address.city).to eq address.city
      expect(station_instance.address.state).to eq address.state
      expect(station_instance.address.zip).to eq address.zip
    end
  end

  describe 'PUT update' do
    it 'updates station with expected attributes' do
      sign_in create(:admin)
      station_form = create(:station_form)
      test_station = Station.where(name: station_form.name).first
      original_id = test_station.id
      new_station = create(:station)
      new_address = create(:address)
      new_station.address = new_address

      put :update, params: { station: { name: new_station.name }, 
                             address: { street: new_station.address.street, 
                                        city: new_station.address.city, 
                                        state: new_station.address.state, 
                                        zip: new_station.address.zip },
                             id: test_station.id }

      expect(test_station.id).to eq original_id
      expect(test_station.name).to eq new_station.name
      expect(test_station.address.street).to eq new_address.street
      expect(test_station.address.city).to eq new_address.city
      expect(test_station.address.state).to eq new_address.state
      expect(test_station.address.zip).to eq new_address.zip
    end

    it 'redirects to the admin dashboard' do
      sign_in create(:admin)
      station_form = create(:station_form)
      station = Station.where(name: station_form.name).first
      new_station = create(:station)
      new_address = create(:address)
      new_station.address = new_address
      put :update, params: { station: { name: new_station.name }, 
                             address: { street: new_station.address.street, 
                                        city: new_station.address.city, 
                                        state: new_station.address.state, 
                                        zip: new_station.address.zip }, 
                             id: station.id }

      expect(response).to redirect_to admins_dashboard_path
    end
  end
end
