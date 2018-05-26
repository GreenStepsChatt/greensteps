module PageObjects
  class WorkList < Base
    def include?(redemptions)
      Array(redemptions).each do |redemption|
        this.has_content? "#{redemption.user.email} #{redemption.value}"
      end
    end

    def selector
      '.work_list'
    end
  end
end
