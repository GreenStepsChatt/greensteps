module PageObjects
  class StationForm < Base
    def name=(name)
      this.fill_in t('helpers.label.station_form.name'), with: name
    end

    def street=(street)
      this.fill_in t('helpers.label.station_form.street'), with: street
    end

    def city=(city)
      this.fill_in t('helpers.label.station_form.city'), with: city
    end

    def select_state(state)
      this.select state, from: t('helpers.label.station_form.state')
    end

    def zip=(zip)
      this.fill_in t('helpers.label.station_form.zip'), with: zip
    end

    def submit
      this.click_on t('helpers.submit.create')
    end

    def selector
      '#new_station_form, #edit_station_form'
    end
  end
end
