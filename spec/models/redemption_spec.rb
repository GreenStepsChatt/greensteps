require 'rails_helper'

RSpec.describe Redemption, type: :model do
  it { should belong_to :user }
  it { should belong_to :prize }
end
