require 'rails_helper'

RSpec.describe 'rake heroku:predestroy', type: :task do
  it 'removes the uploaded before and after photo files' do
    deed = create :deed, :with_photos

    task.execute

    expect(deed.before_photo).to be_deleted_from_storage
    expect(deed.before_photo).to be_deleted_from_storage
  end
end
