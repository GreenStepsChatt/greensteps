module PageObjects
  class AccountSettingsForm < Base
    def change_password(from, to)
      fill_in 'Password', with: to
      fill_in 'Password confirmation', with: to
      fill_in 'Current password', with: from
      click_on 'Update'
    end

    def selector
      'form#edit_user'
    end
  end
end
