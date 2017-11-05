module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?
    content_tag(:div, id: 'error_explanation') do
      safe_join [content_tag(:h3, error_header),
                 content_tag(:ul, safe_join(full_messages_in_li))]
    end
  end

  private

  def full_messages_in_li
    resource.errors.full_messages.map do |msg|
      content_tag(:li, msg)
    end
  end

  def error_header
    I18n.t('errors.messages.not_saved',
           count: resource.errors.count,
        resource: resource.class.model_name.human.downcase)
  end
end
