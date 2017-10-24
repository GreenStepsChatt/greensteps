require 'rails_helper'

RSpec.describe 'prizes/_form' do
  before(:each) { render 'prizes/form', prize: Prize.new }
  subject { rendered }

  it { should require_field '#prize_title' }
  it { should require_field '#prize_quantity' }
  it { should require_field '#prize_cost' }
end
