module PageObjects
  class Dashboard < Base
    def log_deed
      this.find('.stats .add').click
    end

    def lifetime_points
      this.find('#lifetime_points + .value').text.to_i
    end

    def selector
      '.dashboards'
    end
  end
end
