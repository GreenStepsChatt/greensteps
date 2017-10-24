require 'rails_helper'

RSpec.describe Prize, type: :model do
  it { should validate_numericality_of(:cost).is_greater_than(0) }
  it { should validate_numericality_of(:quantity).is_greater_than(0) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :cost }
  it { should validate_presence_of :quantity }
end
