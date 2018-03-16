require 'rails_helper'

RSpec.describe Admins::PrizesController, type: :controller do
  let(:prize) { create(:prize) }

  describe 'POST #create' do
    context 'invalid prize' do
      it 're-renders the form' do
        sign_in create(:admin)

        post :create, params: { prize: attributes_for(:prize, :invalid) }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET edit' do
    it 'returns http success' do
      sign_in create(:admin)
      get :edit, params: { id: prize.id }
      expect(response).to have_http_status(:success)
    end

    it 'renders the #edit view' do
      sign_in create(:admin)
      get :edit, params: { id: prize.id }
      expect(response).to render_template :edit
    end

    it 'assigns prize to be updated to @prize' do
      sign_in create(:admin)
      get :edit, params: { id: prize.id }
      prize_instance = assigns(:prize)

      expect(prize_instance.id).to eq prize.id
      expect(prize_instance.title).to eq prize.title
      expect(prize_instance.quantity).to eq prize.quantity
      expect(prize_instance.cost).to eq prize.cost
    end
  end

  describe 'PUT update' do
    it 'updates prize with expected attributes' do
      sign_in create(:admin)
      new_prize = create(:prize)
      new_title = new_prize.title
      new_quantity = new_prize.quantity
      new_cost = new_prize.cost

      put :update, params: { id: prize.id, prize: { title: new_prize.title, quantity: new_prize.quantity, cost: new_prize.cost } }

      updated_prize = assigns(:prize)
      expect(updated_prize.id).to eq prize.id
      expect(updated_prize.title).to eq new_title
      expect(updated_prize.quantity).to eq new_quantity
      expect(updated_prize.cost).to eq new_cost
    end

    it 'redirects to the admin dashboard' do
      sign_in create(:admin)
      new_prize = create(:prize)
      put :update, params: { id: prize.id, prize: { title: new_prize.title, quantity: new_prize.quantity, cost: new_prize.cost } }
      expect(response).to redirect_to admins_dashboards_show_path
    end
  end

  context 'non-admin user' do
    [
      %i[get new],
      %i[post create]
    ].each do |method, action|
      include_examples 'restricted to admins html response', method, action
    end
  end
end
