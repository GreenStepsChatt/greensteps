require 'rails_helper'

RSpec.describe TrashBag, type: :model do
  it { should belong_to :user }
end
