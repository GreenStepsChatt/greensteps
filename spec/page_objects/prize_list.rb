module PageObjects
  class PrizeList < Base
    def include?(*args)
      this.has_content?(*args)
    end

    def selector
      '.prizes'
    end
  end
end
