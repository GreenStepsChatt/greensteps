module PageObjects
  class DeedForm < Base
    def trash_bags=(number)
      this.fill_in(Deed.human_attribute_name(:trash_bags), with: number)
    end

    def upload_before_photo(path_name)
      attach_file 'deed_before_photo', path_name
    end

    def upload_after_photo(path_name)
      attach_file 'deed_after_photo', path_name
    end

    def submit
      this.click_on t('helpers.submit.create')
    end

    def selector
      '#new_deed'
    end
  end
end
