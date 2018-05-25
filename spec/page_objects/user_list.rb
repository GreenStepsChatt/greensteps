module PageObjects
  class UserList < Base
    def strike(user)
      this.find("#user_#{user.id}").click_on t('admins.users.index.strike')
    end

    def list_item_for(user)
      UserListItem.new(this.find("#user_#{user.id}"))
    end

    def first_user_li
      UserListItem.new(this.first('.user'))
    end

    def selector
      '.users'
    end
  end

  class UserListItem
    attr_reader :this

    def initialize(this)
      @this = this
    end

    def for?(user)
      id == user.id
    end

    def has_one_strike?
      has_strikes?(1)
    end

    def has_strikes?(number)
      this.has_selector?('.strikes', text: number.to_s)
    end

    private

    def id
      this[:id].scan(/\d+/).first.to_i
    end
  end
end
