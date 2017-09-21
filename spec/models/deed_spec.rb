require 'rails_helper'

RSpec.describe Deed, type: :model do
  it { should belong_to :user }
end
