require 'rails_helper'

RSpec.describe 'Linters' do
  it 'All factories are valid' do
    FactoryGirl.lint
  end
end
