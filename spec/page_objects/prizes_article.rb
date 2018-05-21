module PageObjects
  class PrizesArticle < Base
    def redeem(prize)
      this.find("#{label_for(prize)} button").click
    end

    def unredeemed_points
      this.find('header h3').text.scan(/\d+/).first.to_i
    end

    def has_disabled_prize_button?(prize)
      has_selector?("#{label_for(prize)} button:disabled")
    end

    def label_for(prize)
      "label[for='redemption_prize_id_#{prize.id}']"
    end

    def selector
      '.prizes'
    end
  end
end
