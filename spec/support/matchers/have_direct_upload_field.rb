RSpec::Matchers.define :have_direct_upload_field do |selector|
  match do |actual|
    expect(actual).to have_selector("#{selector}[data-direct-upload-url]")
  end

  failure_message do |actual|
    <<~TEXT
      expected the form to have a direct upload file field with selector
      \"#{selector}\", but the html was\n
      #{actual}
    TEXT
  end
end
