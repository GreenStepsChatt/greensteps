require 'rails_helper'

RSpec.describe 'stations/_form' do
  before(:each) do
    render 'admins/stations/form', station_form: build(:station_form)
  end

  it { should require_field '#station_form_name' }
  it { should require_field '#station_form_street' }
  it { should require_field '#station_form_city' }
  it { should require_field '#station_form_state' }
  it { should require_field '#station_form_zip' }
  it do
    should validate_field('#station_form_zip')
      .with(pattern: '\A\d{5}(-\d{4})?\z')
  end
end
