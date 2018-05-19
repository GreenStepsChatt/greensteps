RSpec.configure do |config|
  config.around(:example, :immediately_execute_jobs) do |example|
    Swapper.while('Delayed::Worker')
           .has(:delay_jobs).set_to(false) { example.run }
  end
end
