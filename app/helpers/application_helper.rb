module ApplicationHelper
  def flash_filtered_for_display
    flash.select do |type, message|
      %w[notice alert warning].include?(type) && message.present?
    end
  end
end

class ActionView::Helpers::Tags::NumberField < ActionView::Helpers::Tags::TextField
  def render(*args)
    "#{super}#{'<div class="quantity-nav">
      <div class="quantity-button quantity-up">+</div>
      <div class="quantity-button quantity-down">-</div></div>'}".html_safe
  end
end
