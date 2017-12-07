require 'rails_helper'

RSpec.describe Admins::DashboardsController, type: :controller do
  context 'non-admin user' do
    include_examples 'restricted to admins html response', :get, :show
  end
end
