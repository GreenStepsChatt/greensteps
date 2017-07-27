module PageObjects
  class NavDrawer < Base
    def edit_account_settings
      click_on t('shared.appbar.edit_account')
    end

    def sign_out
      click_on t('shared.appbar.destroy_session')
    end

    def open?
      has_css?('#nav_drawer', visible: true)
    end

    def closed?
      has_css?('#nav_drawer', visible: :hidden)
    end

    def selector
      '#nav_drawer'
    end
  end
end
