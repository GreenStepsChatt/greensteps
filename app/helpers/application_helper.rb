module ApplicationHelper
  def flash_filtered_for_display
    flash.select do |type, message|
      %w[notice alert warning].include?(type) && message.present?
    end
  end

  def css_classes_for_main
    "#{controller_path.split('/').join('-')} #{action_name}"
  end

  # TODO: this should really be a view object
  def link_to_sort_by(column)
    direction =
      if params['column'] == 'total_points'
        params['direction'] == 'DESC' ? 'ASC' : 'DESC'
      else
        params['direction'] == 'ASC' ? 'DESC' : 'ASC'
      end
    link_to t(".#{column}"), column: column, direction: direction
  end
end
