module PageObjects
  class StationList < Base
    def include?(*args)
      this.has_content?(*args)
    end

    def selector
      '.stations'
    end
  end
end
