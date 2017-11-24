RSpec::Matchers.define :validate_field do |selector|
  match do |actual|
    expect(actual).to have_selector(selector_with_val_attrs)
  end

  chain :with do |validations|
    @validations = validations
  end

  define_method :selector_with_val_attrs do
    @validations.reduce(selector) do |accumulator, (attribute, value)|
      accumulator + "[#{attribute}='#{value}']"
    end
  end

  failure_message do |actual|
    <<~TEXT + actual.to_s
      expected the form to validate field \"#{selector}\" with #{validations}
      but the html was\n
    TEXT
  end
end
