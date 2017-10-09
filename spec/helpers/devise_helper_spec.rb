require 'rails_helper'

RSpec.describe DeviseHelper, type: :helper do
  describe '#devise_error_messages!' do
    before(:each) do
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
      end
    end

    it 'returns h3 error message header' do
      header = '<h3>2 errors prohibited this modelname from being saved:</h3>'
      expect(helper.devise_error_messages!).to include(header)
    end

    it 'returns list of error messages' do
      error_list = '<li>Error Message 1</li><li>Error Message 2</li>'
      expect(helper.devise_error_messages!).to include(error_list)
    end

    it 'returns div with error_explanation as id' do
      div = '<div id="error_explanation">'
      expect(helper.devise_error_messages!).to include(div)
    end
  end
end
