require 'rails_helper'

RSpec.describe RedemptionsController, type: :controller do
  describe 'POST #create' do
    context 'for a user who does not have 5+ available points' do
      it 'does not create a redemption' do
        user = create(:user)
        sign_in user

        expect { post :create, xhr: true }.to_not \
          change { user.reload.redemptions.size }
      end
    end

    it 'does not respond to html' do
      sign_in create(:user)

      expect { post :create }.to raise_error ActionController::UnknownFormat
    end
  end
end
