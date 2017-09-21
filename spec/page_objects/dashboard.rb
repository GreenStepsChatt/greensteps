module PageObjects
  class Dashboard < Base
    def log_deed
      this.find('.stats .add').click
    end

    def trash_bag_count
      this.find('.trash_bags .count').text.to_i
    end

    def miles_walked
      this.find('.miles .count').text.to_i
    end

    def selector
      '.dashboard'
    end
  end
end
