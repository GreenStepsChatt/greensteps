module PageObjects
  class AdminList < Base
    def include?(admin)
      this.has_text? admin.email
    end

    def remove(admin)
      this.find('li', text: admin.email).find('.delete_admin').click
    end

    def selector
      '.admins'
    end
  end
end
