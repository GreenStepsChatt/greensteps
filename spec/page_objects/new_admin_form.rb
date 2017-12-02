module PageObjects
  class NewAdminForm < Base
    def email=(email)
      this.fill_in t('helpers.label.admin.email'), with: email
    end

    def submit
      this.click_on t('helpers.submit.create')
    end

    def selector
      '#new_admin'
    end
  end
end
