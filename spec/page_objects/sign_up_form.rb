module PageObjects
  class SignUpForm < Base
    def fill_and_submit_with(user_info)
      self.email = user_info.email
      self.password = user_info.password
      submit
    end

    def email=(email)
      this.fill_in 'sign_up_user_email', with: email
    end

    def password=(password)
      this.fill_in 'sign_up_user_password', with: password
      this.fill_in 'sign_up_user_password_confirmation', with: password
    end

    def submit
      this.click_on 'Sign up'
    end

    def selector
      '#new_user_registration'
    end
  end
end
