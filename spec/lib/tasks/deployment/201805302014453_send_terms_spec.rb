require 'rails_helper'

RSpec.describe 'rake after_party:send_terms', type: :task do
  include MailerHelpers

  it 'sends an email to each existing user with the terms document attached',
     :immediately_execute_jobs do
    user = create :user

    task.execute

    expect(last_email.subject).to eq "We've updated our terms and conditions"
    expect(last_email.to).to eq [user.email]
    expect(last_email.attachments.first.filename).to eq 'terms.pdf'
  end
end
