module PageObjects
  class AdminDashboard < Base
    def manage_admins
      this.click_link t('admins.dashboards.show.miscellaneous.admins')
    end

    def add_prize
      this.find('.add_prize').click
    end

    def selector
      '.admins-dashboards'
    end
  end
end
