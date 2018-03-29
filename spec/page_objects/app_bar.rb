module PageObjects
  class AppBar < Base
    def open_drawer
      find('.menu_toggler').click
      wait_for_animations
    end

    def close_drawer
      find('#nav_drawer_container').click
      wait_for_animations
    end

    def selector
      '#app_bar'
    end
  end
end
