require 'rails_helper'

RSpec.describe Role, type: :model do
  subject { build_stubbed :role }
  it { should have_and_belong_to_many(:users) }
end
