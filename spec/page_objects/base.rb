module PageObjects
  class Base
    include Capybara::DSL
    include AbstractController::Translation

    def initialize(skip_error = false)
      raise NotFound.new page, self.class.name unless on_page? || skip_error
    end

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
end
