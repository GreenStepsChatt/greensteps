module PageObjects
  class Dashboard < Base
    def log_deed
      this.find('.stats button').click
    end

    def total_points
      this.find('.total_points .count').text.to_i
    end

    def selector
      '.dashboards'
    end
  end
end
