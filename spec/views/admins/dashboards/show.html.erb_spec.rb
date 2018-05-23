require 'rails_helper'

RSpec.describe 'admins/dashboards/show' do
  before(:each) do
    render template: 'admins/dashboards/show', locals: {
      prizes: [],
      stations: []
    }
  end

  it { should have_link t('admins.dashboards.show.miscellaneous.user_list') }
end
