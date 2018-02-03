module PageObjects
  class NotFound < StandardError
    def initialize(page, po_name)
      @page = page
      msg = <<~TEXT
        The page object #{po_name} wasn't on the page when the object was
        accessed.
          - The current page title is "#{title}".
          - Classes applied to the main element are "#{main_classes}".
      TEXT
      super(msg)
    end

    def title
      @page.title
    end

    def main_classes
      main_element = @page.find('main')
      if main_element.present?
        classes = main_element[:class]
        classes.presence || '(no classes applied to main element)'
      else
        '(no main element found)'
      end
    end
  end
end
