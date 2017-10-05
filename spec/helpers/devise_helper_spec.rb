require 'rails_helper'

RSpec.describe DeviseHelper, type: :helper do
  describe '#devise_error_messages!' do
    it 'returns div error_messages with h3 header' do
      without_partial_double_verification do
        allow(helper).to receive_message_chain('resource.errors')\
          .and_return(
            ['Error Message 1', 'Error Message 2']
          )
        allow(helper).to receive_message_chain('resource.errors.full_messages')\
          .and_return(
            ['Error Message 1', 'Error Message 2']
          )
        allow(helper).to \
          receive_message_chain('resource.class.model_name.human')
          .and_return('ModelName')
        msg = '<h3>2 errors prohibited this modelname from being saved:</h3>'
        expect(helper.devise_error_messages!).to include(msg)
      end
    end
  end
end
