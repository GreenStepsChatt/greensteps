RSpec::Matchers.define :flash_message do |expected_message|
  match do |page|
    page.has_css? ".flash-message", text: expected_message
  end
end
