module PageObjects
  class Base
    include Capybara::DSL
    include AbstractController::Translation

    # Whenever a new page object is defined, add an accessor method for it to
    # to the main module. This method is named after the page object's class. It
    # is responsible for either grabbing the existing page object, or creating a
    # new one, as well as ensuring that the object is currently on the page.
    #
    # rubocop:disable Metrics/MethodLength
    def self.inherited(subclass)
      po_name = subclass.name.underscore.split('/').last
      int_method_nm = "_#{po_name}_"

      PageObjects.module_eval do
        define_method po_name do
          page_object = send(int_method_nm)
          raise NotFound, po_name unless page_object.on_page?
          return page_object
        end
      end

      PageObjects.module_eval do
        define_method int_method_nm do
          instance_variable_get("@#{po_name}") ||
            instance_variable_set("@#{po_name}", subclass.new)
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    def on_page?(options = {})
      has_css?(selector, options)
    end

    def hidden?
      !visible?
    end

    delegate :visible?, to: :this

    def this
      find(selector)
    end
  end

  class NotFound < StandardError
    def initialize(po_name = nil)
      details = " (#{po_name})" if po_name.present?
      msg = <<~TEXT
        The page object#{details} wasn't on the page when the object was
        accessed.
      TEXT
      super(msg)
    end
  end
end
