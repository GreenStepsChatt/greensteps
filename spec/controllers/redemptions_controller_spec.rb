require 'rails_helper'

RSpec.describe RedemptionsController, type: :controller do
  describe 'POST #create' do
    it 'attaches the redemption to the current_user' do
      prize = create :prize, cost: 5
      user = create :user
      sign_in user
      AddPointsToUser.new(user, 5)
      params = { redemption: { prize_id: prize.id } }

      expect { post :create, xhr: true, params: params }.to \
        change { user.redemptions.count }.from(0).to(1)
    end

    context 'when the user does not have enough points' do
      it 'adds the redemption errors to the flash' do
        prize = create :prize
        sign_in create(:user)

        post :create, xhr: true, params: { redemption: { prize_id: prize.id } }

        expect(flash[:alert]).to include \
          t('activerecord.errors.models.redemption.not_enough_points')
      end
    end

    it 'does not respond to html' do
      prize = create :prize
      sign_in create(:user)

      expect { post :create, params: { redemption: { prize_id: prize.id } } }
        .to raise_error ActionController::UnknownFormat
    end
  end
end
