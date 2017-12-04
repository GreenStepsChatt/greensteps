RSpec.configure do |config|
  # TODO: remove when upgrading to RSpec 4
  config.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context 'view spec context' do
  subject { rendered }
end

RSpec.configure do |config|
  config.include_context 'view spec context', type: :view
end
