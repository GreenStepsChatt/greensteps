require 'rails_helper'

RSpec.describe Strike, type: :model do
  it { should belong_to(:user).counter_cache(true) }
end
