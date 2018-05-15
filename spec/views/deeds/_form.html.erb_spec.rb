require 'rails_helper'

RSpec.describe 'deeds/_form' do
  before(:each) { render 'deeds/form', deed: Deed.new }

  it { should validate_field('#deed_trash_bags').with(min: 0, step: 1) }
  it { should have_direct_upload_field('#deed_before_photo') }
  it { should have_direct_upload_field('#deed_after_photo') }
  it { should require_field('#deed_before_photo') }
  it { should require_field('#deed_after_photo') }
end
