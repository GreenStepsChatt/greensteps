module PageObjects
  class NavDrawer < Base
    def open_admin_dashboard
      click_on t('shared.navigation.admin_dashboard')
    end

    def edit_account_settings
      click_on t('shared.navigation.edit_account')
    end

    def sign_out
      click_on t('shared.navigation.destroy_session')
    end

    def selector
      '#nav_drawer'
    end
  end
end
