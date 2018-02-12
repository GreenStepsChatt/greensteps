RSpec.configure do |config|
  config.around(:example, :with_active_job_test_adapter) do |example|
    original_adapter = ActiveJob::Base.queue_adapter
    ActiveJob::Base.queue_adapter = :test
    example.run
    ActiveJob::Base.queue_adapter = original_adapter
  end
end
