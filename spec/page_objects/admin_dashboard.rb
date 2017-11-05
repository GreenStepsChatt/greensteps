module PageObjects
  class AdminDashboard < Base
    def add_prize
      this.find('.add_prize').click
    end

    def selector
      '.admin-dashboards'
    end
  end
end
