require_relative '../support/synchronization_helper.rb'

module PageObjects
  class Base
    include Capybara::DSL
    include AbstractController::Translation
    include SynchronizationHelper

    def initialize(skip_error = false)
      raise NotFound.new page, self.class.name unless on_page? || skip_error
    end

    def on_page?(options = {})
      has_css?(selector, options)
    end

    def not_on_page?
      has_no_css?(selector)
    end

    def this
      find(selector)
    end
  end
end
