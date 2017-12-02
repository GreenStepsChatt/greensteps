RSpec.shared_examples 'an admin controller' do
  RESOURCEFUL_VERB_ACTION_PAIRS ||= [
    %i[get index],
    %i[get new],
    %i[post create],
    %i[get show],
    %i[get edit],
    %i[patch update],
    %i[put update], # TODO: what happens in here if only one verb is defined?
    %i[delete destroy]
  ].freeze

  before { request.env['HTTP_REFERER'] = 'http://www.previous_page.com' }

  RESOURCEFUL_VERB_ACTION_PAIRS.each do |verb, action|
    next unless described_class.action_methods.include? action.to_s

    describe "#{verb.upcase} ##{action}" do
      before do
        sign_in create(:user)
        send(verb, action)
      end

      it 'should redirect back' do
        expect(response).to redirect_to 'http://www.previous_page.com'
      end

      it 'should flash an alert message' do
        expect(flash[:alert]).to eq t('restricted_to_admins')
      end
    end
  end
end
