RSpec::Matchers.define :validate_field do |selector, validations|
  match do |actual|
    expect(actual).to have_selector("#{selector}#{validations_selector}")
  end

  define_method :validations_selector do
    validations.reduce('') do |selector, (attribute, value)|
      selector + "[#{attribute}='#{value}']"
    end
  end

  failure_message do |actual|
    <<~TEXT + actual.to_s
      expected the form to validate field \"#{selector}\" with #{validations}
      but the html was\n
    TEXT
  end
end
