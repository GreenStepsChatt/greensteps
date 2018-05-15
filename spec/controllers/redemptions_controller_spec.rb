require 'rails_helper'

RSpec.describe RedemptionsController, type: :controller do
  describe 'POST #create' do
    context 'when the user does not have enough points' do
      it 'adds the redemption errors to the flash' do
        prize = create :prize
        sign_in create(:user)

        post :create, xhr: true, params: { redemption: { prize_id: prize.id } }

        expect(flash[:alert]).to include \
          t('activerecord.errors.models.redemption.not_enough_points')
      end
    end
  end
end
