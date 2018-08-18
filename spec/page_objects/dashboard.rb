module PageObjects
  class Dashboard < Base
    def request_gift_card
      this.find('.new_redemption button[type="submit"]').click
    end

    def lifetime_points
      this.find('#lifetime_points + .value').text.to_i
    end

    def points_redeemed_this_month
      this.find('#points_redeemed_this_month + .value').text.to_i
    end

    def has_gift_card_button?
      this.has_selector?('.new_redemption button[type="submit"]')
    end

    def selector
      '.dashboards'
    end
  end
end
