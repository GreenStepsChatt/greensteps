require 'rails_helper'

RSpec.describe Deed, type: :model do
  subject { build_stubbed :deed }

  it { should belong_to :user }
  it { should validate_presence_of :trash_bags }

  it 'is invalid unless there is at least one trash bag' do
    deed = build_stubbed :deed, trash_bags: 0

    expect(deed).to be_invalid
  end

  it 'should have a default of 1 trash bag' do
    deed = Deed.new

    expect(deed.trash_bags).to eq 1
  end
end
