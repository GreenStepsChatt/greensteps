require 'rails_helper'

RSpec.describe 'rake rolify:add_role', type: :task do
  it 'adds the role to the user' do
    user = create :user

    task.execute([:developer, user.email])

    expect(user.reload).to have_role :developer
  end
end
