namespace :after_party do
  desc 'Deployment task: Send email to existing users with a copy of the terms document.'
  task send_terms: :environment do
    Rails.logger.info "Running deploy task 'send_terms'"

    User.find_each do |user|
      TermsMailer.updated_terms_email(user).deliver_later
    end

    # Update task as completed.  If you remove the line below, the task will
    # run with every deploy (or every time you call after_party:run).
    AfterParty::TaskRecord.create version: '20180530214453'
  end
end
