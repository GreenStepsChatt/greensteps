require 'rails_helper'

RSpec.describe Admins::RedemptionsController, type: :controller do
  describe 'PATCH #update' do
    it 'does not respond to html' do
      redemption = create :redemption
      sign_in create(:admin)
      expect { patch :update, params: { id: redemption.id } }.to \
        raise_error ActionController::UnknownFormat
    end
  end
end
