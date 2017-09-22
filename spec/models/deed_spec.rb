require 'rails_helper'

RSpec.describe Deed, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of :trash_bags }
  it { should validate_presence_of :miles }

  it 'is invalid unless there is at least one trash bag or mile walked' do
    deed = build :deed, trash_bags: 0, miles: 0

    expect(deed).to be_invalid
  end

  it 'should have a default of 1 trash bag' do
    deed = Deed.new

    expect(deed.trash_bags).to eq 1
  end

  it 'should have a default of 1 mile walked' do
    deed = Deed.new

    expect(deed.miles).to eq 1
  end
end
