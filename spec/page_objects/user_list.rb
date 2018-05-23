module PageObjects
  class UserList < Base
    def strike(user)
      this.find("#user_#{user.id}").click_on t('admins.users.index.strike')
    end

    def list_item_for(user)
      UserListItem.new("#{selector} #user_#{user.id}")
    end

    def selector
      '.users'
    end
  end

  class UserListItem < Base
    attr_reader :selector

    def initialize(selector)
      @selector = selector
    end

    def has_one_strike?
      has_strikes?(1)
    end

    def has_strikes?(number)
      this.has_selector?('.strikes', text: number.to_s)
    end
  end
end
