module PageObjects
  class AppBar < Base
    def open_drawer
      toggler.click
    end

    def close_drawer
      element_in_background.click
    end

    def selector
      '#app_bar'
    end

    private

    def toggler
      @toggler ||= find('.menu_toggler')
    end

    def element_in_background
      @element_in_background ||= find('#nav_drawer_container')
    end
  end
end
