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
      if column == 'total_points'
        sort_column == 'total_points' && sort_direction == 'DESC' ? 'ASC' : 'DESC'
      else
        column == sort_column && sort_direction == 'ASC' ? 'DESC' : 'ASC'
      end
    css_classes =
      sort_column == column ? "sorted_by_this #{sort_direction.downcase}" : ''
    link_to t(".#{column}"),
            { column: column, direction: direction },
            class: css_classes
  end
end
