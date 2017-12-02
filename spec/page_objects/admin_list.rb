module PageObjects
  class AdminList < Base
    def include?(admin)
      this.has_text? admin.email
    end

    def selector
      '.admins'
    end
  end
end
