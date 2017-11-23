RSpec::Matchers.define :flash_message do |expected_message|
  match do |page|
    page.has_css? '.flash-message', text: expected_message
  end

  failure_message do |page|
    <<~TEXT
      expected
        #{flash_html}
      to include "#{expected_message}"

      more info:
        - the page title is "#{page.title}"
        - classes applied to the main element are "#{page.find('main')[:class]}"
    TEXT
  end

  define_method :flash_html do
    if page.has_css?('.flash-message')
      page.find('.flash-message').native.to_html
    else
      '(no flash element present)'
    end
  end
end
