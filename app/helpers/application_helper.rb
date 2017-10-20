module ApplicationHelper
  def flash_filtered_for_display
    flash.select do |type, message|
      %w[notice alert warning].include?(type) && message.present?
    end
  end

  def form_for(record, options = {}, &block)
    options.merge! builder: ApplicationFormBuilder
    super(record, options, &block)
  end
end
