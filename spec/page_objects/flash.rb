module PageObjects
  class Flash < Base
    def dismiss
      this.find('button').click
    end

    def selector
      '.flash-message'
    end
  end
end
