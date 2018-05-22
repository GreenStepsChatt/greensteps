require 'rails_helper'

RSpec.describe RedemptionForm, type: :form do
  subject { build :redemption_form }

  describe RedemptionForm::PrizeChoice do
    describe '.disabled?' do
      it 'should be true if the user does not have enough points' do
        user = create :user
        prize = create :prize

        expect(RedemptionForm::PrizeChoice.new(prize, user)).to be_disabled
      end
    end
  end
end
