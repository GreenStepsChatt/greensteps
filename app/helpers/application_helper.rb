module ApplicationHelper
  def flash_filtered_for_display
    flash.select do |type, message|
      %w[notice alert warning].include?(type) && message.present?
    end
  end
end

module ActionView
  module Helpers
    module Tags
      class NumberField < TextField
        def render(*args)
          safe_join([super, raw('<div class="quantity-nav">
            <div class="quantity-button quantity-up">+</div>
            <div class="quantity-button quantity-down">-</div></div>')])
        end
      end
    end
  end
end
