require 'rails_helper'

RSpec.describe Deed, type: :model do
  subject { build_stubbed :deed }

  it { should belong_to :user }
  it { should validate_numericality_of(:trash_bags).is_greater_than(0) }
  it { should validate_presence_of(:trash_bags) }

  it 'is invalid unless there is at least one trash bag' do
    deed = build_stubbed :deed, trash_bags: 0

    expect(deed).to be_invalid
  end

  it 'should have a default of 1 trash bag' do
    deed = Deed.new

    expect(deed.trash_bags).to eq 1
  end

  context 'with out a before photo' do
    it 'is invalid' do
      deed = build :deed, with_before_photo: false

      expect(deed).to be_invalid
    end
  end

  context 'with out an after photo' do
    it 'is invalid' do
      deed = build :deed, with_after_photo: false

      expect(deed).to be_invalid
    end
  end

  describe '.total_trash_bags' do
    it 'should add up all of the trash bags in the scope' do
      [5, 1, 3].each { |n| create :deed, trash_bags: n }

      expect(Deed.total_trash_bags).to eq 9
    end
  end
end
