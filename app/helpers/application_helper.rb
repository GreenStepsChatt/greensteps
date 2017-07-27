module ApplicationHelper
  def flash_filtered_for_display
    flash.select do |type, message|
      %w[notice alert warning].include?(type) && message.present?
    end
  end
end
