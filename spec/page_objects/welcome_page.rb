module PageObjects
  class WelcomePage < Base
    def selector
      '.welcome.index'
    end

    def open_log_in_form
      this.find('#log_in header').click
    end

    def open_sign_up_form
      this.find('#sign_up header').click
    end
  end
end
