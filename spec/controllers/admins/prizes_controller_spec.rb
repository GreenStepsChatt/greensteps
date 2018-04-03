require 'rails_helper'

RSpec.describe Admins::PrizesController, type: :controller do

  describe 'POST #create' do
    context 'invalid prize' do
      it 're-renders the form' do
        sign_in create(:admin)

        post :create, params: { prize: attributes_for(:prize, :invalid) }

        expect(response).to render_template(:new)
      end
    end
  end
  
  describe 'PUT #update' do
    context 'invalid prize' do
      it 're-renders the form' do
        sign_in create(:admin)
        prize = create(:prize)

        put :update, params: { id: prize.id, prize: attributes_for(:prize, :invalid) }

        expect(response).to render_template(:edit)
      end
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
