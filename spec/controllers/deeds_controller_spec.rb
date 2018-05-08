require 'rails_helper'

RSpec.describe DeedsController, type: :controller do
  describe 'POST #create' do
    context 'with invalid deed' do
      it 're-renders the form' do
        sign_in create(:user)

        post :create, params: { deed: attributes_for(:deed, :invalid) }

        expect(response).to render_template(:new)
      end
    end

    it 'uploads the before and after photos' do
      sign_in create(:user)

      post :create, params: { deed: attributes_for(:deed).merge(
        before_photo: fixture_file_upload(
          'files/trashed_park.jpeg',
          'image/jpeg'
        ),
        after_photo: fixture_file_upload('files/clean_park.jpeg', 'image/jpeg')
      ) }

      deed = Deed.first
      expect(deed.before_photo).to be_attached
      expect(deed.after_photo).to be_attached
    end
  end
end
