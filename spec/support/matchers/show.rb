RSpec::Matchers.define :show do |page_object_name|
  match do |_page|
    page_object.on_page? && page_object.visible?
  end

  failure_message do |_page|
    <<~TEXT
      The page object "#{page_object_name}" wasn't on the page when the object
      was accessed.
        - The current page title is "#{title}".
        - Classes applied to the main element are "#{main_classes}".
    TEXT
  end

  match_when_negated do |_page|
    !page_object.on_page? || page_object.hidden?
  end

  define_method :page_object do
    send(page_object_name, true)
  end

  define_method :title do
    page.title
  end

  define_method :main_classes do
    main_element = page.find('main')
    if main_element.present?
      classes = main_element[:class]
      classes.presence || '(no classes applied to main element)'
    else
      '(no main element found)'
    end
  end
end
