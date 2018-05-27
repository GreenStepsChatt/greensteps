require 'rails_helper'

RSpec.describe Admins::RedemptionsController, type: :controller do
  describe 'PATCH #update' do
    it 'does not respond to html' do
      redemption = create :redemption
      sign_in create(:admin)
      expect { patch :update, params: { id: redemption.id } }.to \
        raise_error ActionController::UnknownFormat
    end

    it 'does nothing if a confirmation number is not provided' do
      redemption = create :redemption
      sign_in create(:admin)

      params = { id: redemption.id, redemption: { value: 3 } }
      expect { patch :update, xhr: true, params: params }.to_not \
        change { redemption.updated_at }
    end
  end
end
