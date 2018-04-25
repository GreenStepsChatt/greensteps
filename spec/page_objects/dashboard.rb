module PageObjects
  class Dashboard < Base
    def log_deed
      this.find('.stats .add').click
    end

    def trash_bag_count
      this.find('.trash_bags .count').text.to_i
    end

    def total_points
      this.find('.total_points .count').text.to_i
    end

    def selector
      '.dashboards'
    end
  end
end
