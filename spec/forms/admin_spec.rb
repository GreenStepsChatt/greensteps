require 'rails_helper'

RSpec.describe Admin, type: :form do
  it { should validate_presence_of :email }

  it 'is invalid if there is no user with the provided email' do
    admin = Admin.new(email: 'not_in_the_db@example.com')

    expect(admin).to be_invalid
  end
end
