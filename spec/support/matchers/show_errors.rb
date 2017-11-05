RSpec::Matchers.define :show_errors do |_expected|
  match do |actual|
    actual.has_css?('#error_explanation')
  end
end
