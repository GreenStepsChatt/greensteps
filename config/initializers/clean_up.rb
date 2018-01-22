# Delete old logs automatically when the server or console are started. For the
# test environment, this is done in a before(:suite) hook.
if Rails.env.development? && ENV.fetch('AUTO_CLEAR_LOGS', false)
  `rake log:clear LOG=development`
end
