module PageObjects
  class LogInForm < Base
    def fill_and_submit_for(user)
      self.email = user.email
      self.password = user.password
      submit
    end

    def email=(email)
      this.fill_in 'Email', with: email
    end

    def password=(password)
      this.fill_in 'Password', with: password
    end

    def submit
      this.click_on 'Log in'
    end

    def selector
      '#new_user_session'
    end
  end
end
