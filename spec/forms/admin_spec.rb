require 'rails_helper'

RSpec.describe Admin, type: :form do
  it { should validate_presence_of :email }

  it 'is invalid if there is no user with the provided email' do
    admin = Admin.new(email: 'not_in_the_db@example.com')

    expect(admin).to be_invalid
  end

  describe '#save' do
    it 'grants the user the admin role' do
      user = create :user
      admin = Admin.new(email: user.email)

      admin.save

      expect(user).to have_role(:admin)
    end
  end

  describe '#demote' do
    it 'removes the admin role' do
      user = create :admin
      admin = Admin.new(email: user.email)

      admin.demote

      expect(user).to_not have_role(:admin)
    end
  end

  describe '.find' do
    it 'initializes a new admin object that is tied to the specified user' do
      user = create :admin

      admin = Admin.find(user.id)

      expect(admin.email).to eq user.email
    end
  end
end
