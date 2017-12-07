RSpec.shared_examples 'restricted to admins html response' do |method, action|
  before(:each) do
    request.env['HTTP_REFERER'] = 'http://www.previous_page.com'
    sign_in create(:user)
  end

  let(:params) {}

  describe "#{method.to_s.upcase} ##{action}" do
    it 'redirects back' do
      send(method, action, params: params)
      expect(response).to redirect_to 'http://www.previous_page.com'
    end

    it 'flashes an alert message' do
      send(method, action, params: params)
      expect(flash[:alert]).to eq t('admins_only')
    end
  end
end

RSpec.shared_examples 'restricted to admins ajax response' do |method, action|
  before(:each) { sign_in create(:user) }

  let(:params) {}

  describe "#{method.to_s.upcase} ##{action} (XHR)" do
    it 'gives a 401: Unauthorized response' do
      send(method, action, params: params, xhr: true)
      expect(response).to have_http_status :unauthorized
    end

    it 'flashes an alert message' do
      send(method, action, params: params, xhr: true)
      expect(flash[:alert]).to eq t('admins_only')
    end
  end
end
