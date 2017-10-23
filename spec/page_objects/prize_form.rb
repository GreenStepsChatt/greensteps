module PageObjects
  class PrizeForm < Base
    def fill_and_submit_for(prize)
      self.title = prize.title
      self.quantity = prize.quantity
      self.cost = prize.cost
      submit
    end

    def title=(title)
      this.fill_in(Prize.human_attribute_name(:title), with: title)
    end

    def quantity=(quantity)
      this.fill_in(Prize.human_attribute_name(:quantity), with: quantity)
    end

    def cost=(cost)
      this.fill_in(Prize.human_attribute_name(:cost), with: cost)
    end

    def submit
      this.click_on t('helpers.submit.create')
    end

    def selector
      '#new_prize'
    end
  end
end
