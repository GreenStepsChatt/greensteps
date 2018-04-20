require 'rails_helper'

RSpec.describe 'stations/_form' do
  before(:each) do
    render 'admins/stations/form', station_form: build(:station_form)
  end

  it { should require_field '#station_form_name' }
  it { should validate_field('#station_form_latitude').with(min: -90, max: 90) }
  it do
    should validate_field('#station_form_longitude').with(min: -180, max: 180)
  end

  it do
    should validate_field('#station_form_zip')
      .with(pattern: '^\d{5}(-\d{4})?$')
  end
end
