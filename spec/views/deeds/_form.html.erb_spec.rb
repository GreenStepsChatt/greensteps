require 'rails_helper'

RSpec.describe 'deeds/_form' do
  before(:each) { render 'deeds/form', deed: Deed.new }

  it { should validate_field '#deed_trash_bags', min: 0, step: 1 }
  it { should validate_field '#deed_miles', min: 0, step: 1 }
end
