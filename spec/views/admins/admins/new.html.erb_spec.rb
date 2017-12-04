require 'rails_helper'

RSpec.describe 'admins/admins/new' do
  before(:each) do
    render template: 'admins/admins/new', locals: { admin: Admin.new }
  end

  it { should require_field '#admin_email' }
end
