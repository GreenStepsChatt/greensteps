module PageObjects
  class AdminManager < Base
    def new_admin
      this.find('.new_admin').click
    end

    def selector
      '.admins-admins.index'
    end
  end
end
