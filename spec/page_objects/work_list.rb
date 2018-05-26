module PageObjects
  class WorkList < Base
    def include?(redemptions)
      Array(redemptions).each do |redemption|
        this.has_content? text_for(redemption)
      end
    end

    def has_no_row_with?(redemption)
      this.has_no_content? text_for(redemption)
    end

    def fulfill(redemption, confirmation_number)
      row = this.find("tr#redemption_#{redemption.id}")
      row.fill_in 'redemption_confirmation_number', with: confirmation_number
      row.click_on t('helpers.submit.create')
    end

    def selector
      '.work_list'
    end

    private

    def text_for(redemption)
      "#{redemption.user.email} #{redemption.value}"
    end
  end
end
