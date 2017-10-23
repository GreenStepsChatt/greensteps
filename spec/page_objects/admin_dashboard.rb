module PageObjects
  class AdminDashboard < Base
    def add_prize
      this.find('.add_prize').click
    end

    def selector
      '.admin_dashboard'
    end
  end
end
