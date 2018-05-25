require 'rails_helper'

RSpec.describe RedemptionsController, type: :controller do
  describe 'POST #create' do
    it 'attaches the redemption to the current_user' do
      user = create :user, total_points: 5
      sign_in user

      expect { post :create, xhr: true }.to \
        change { user.redemptions.count }.from(0).to(1)
    end

    it 'does not respond to html' do
      sign_in create(:user)

      expect { post :create }.to raise_error ActionController::UnknownFormat
    end
  end
end
