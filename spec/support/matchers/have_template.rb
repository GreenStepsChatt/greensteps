RSpec::Matchers.define :have_template do |controller, action|
  match do |page|
    page.has_css? ".#{controller}.#{action}"
  end
end
