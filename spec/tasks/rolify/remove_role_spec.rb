require 'rails_helper'

RSpec.describe 'rake rolify:remove_role', type: :task do
  it 'removes the role from the user' do
    user = create :developer

    task.execute([:developer, user.email])

    expect(user.reload).to_not have_role :developer
  end
end
