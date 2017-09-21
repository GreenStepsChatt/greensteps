module PageObjects
  class DeedForm < Base
    def trash_bags=(number)
      this.fill_in('Trash bags', with: number)
    end

    def miles_walked=(number)
      this.fill_in('Miles walked', with: number)
    end

    def submit
      this.click_on t('helpers.submit.create')
    end

    def selector
      '#new_deed'
    end
  end
end
