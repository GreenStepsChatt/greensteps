require 'rails_helper'

RSpec.describe 'prizes/_form' do
  before(:each) { render 'admins/prizes/form', prize: Prize.new }

  it { should require_field '#prize_title' }
  it { should require_field '#prize_quantity' }
  it { should require_field '#prize_cost' }
  it { should validate_field('#prize_quantity').with(min: 1, step: 1) }
  it { should validate_field('#prize_cost').with(min: 1, step: 1) }
end
