namespace :after_party do
  desc 'Deployment task: confirm_existing_users'
  task confirm_existing_users: :environment do
    log_message = "Running deploy task 'confirm_existing_users'"
    puts log_message
    Rails.logger.info log_message

    User.update confirmed_at: Time.zone.now

    # Update task as completed.  If you remove the line below, the task will
    # run with every deploy (or every time you call after_party:run).
    AfterParty::TaskRecord.create version: '20171125051622'
  end
end
