module PageObjects
  class PrizesArticle < Base
    def redeem(prize)
      this.find("label[for='redemption_prize_id_#{prize.id}'] button").click
    end

    def unredeemed_points
      this.find('header h3').text.scan(/\d+/).first.to_i
    end

    def selector
      '.prizes'
    end
  end
end
