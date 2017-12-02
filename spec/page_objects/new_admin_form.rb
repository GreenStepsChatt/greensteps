module PageObjects
  class NewAdminForm < Base
    def email=(email)
      this.fill_in User.human_attribute_name(:email), with: email
    end

    def submit
      this.click_on t('helpers.submit.create')
    end

    def selector
      '#new_admin'
    end
  end
end
