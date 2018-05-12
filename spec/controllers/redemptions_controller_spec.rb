require 'rails_helper'

RSpec.describe RedemptionsController, type: :controller do
  describe 'POST #create' do
    let(:prize) do
      create(:prize)
    end

    let(:user) do 
      create(:user)
    end

    before do
      prize.save
      sign_in user
    end

    after do
      sign_out user
      prize.delete
    end
    
    context 'without enough points' do
      let(:deed) do
        create(:deed, trash_bags: prize.cost - 1, user: user)
      end

      it 'shows an error' do
        post :create, params: { prize_id: prize.id }
        expect(flash[:notice]).to match(
          "Sorry, you don't have enough points for this prize!"
        )
      end
      
      it 're-renders the form' do
        post :create, params: { prize_id: prize.id }
        expect(response).to redirect_to new_prize_redemption_path
      end
    end
    
    context 'with enough points' do
      it 'shows a success message' do
        create(:deed, trash_bags: prize.cost + 1, user: user)
        post :create, params: { prize_id: prize.id }
        expect(flash[:notice]).to match("Prize successfully redeemed!")
      end

      it 'redirects to the dashboard' do
        create(:deed, trash_bags: prize.cost + 1, user: user)
        post :create, params: { prize_id: prize.id }
        expect(response).to redirect_to dashboard_path 
      end
    end
  end
end
