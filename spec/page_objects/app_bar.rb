module PageObjects
  class AppBar < Base
    def open_drawer
      find('.menu_toggler').click
      complete_animations
    end

    def close_drawer
      find('#nav_drawer_container').click
      complete_animations
    end

    def click_on_logo
      find('.logo').click
    end

    def selector
      '#app_bar'
    end
  end
end
