module PageObjects
  class NavDrawer < Base
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
