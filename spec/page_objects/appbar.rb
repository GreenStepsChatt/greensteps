module PageObjects
  class Appbar < Base
    def open_drawer
      toggler.click
    end

    def close_drawer
      element_in_background.click
    end

    def selector
      'nav'
    end

    private
    def toggler
      @toggler ||= find('.fa-navicon')
    end

    def element_in_background
      @element_in_background ||= find('#nav_drawer_container')
    end
  end

end
