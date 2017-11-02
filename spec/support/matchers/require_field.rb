RSpec::Matchers.define :require_field do |selector|
  match do |actual|
    expect(actual).to have_selector("#{selector}[required]")
  end
end
