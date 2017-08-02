module PageObjects
  class Dashboard < Base
    def add_trash_bag
      this.find('.trash_bags .add').click
    end

    def trash_bag_count
      this.find('.trash_bags .count').text
    end

    def selector
      '#dashboard'
    end
  end
end
