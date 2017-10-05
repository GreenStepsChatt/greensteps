module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?
    content_tag(:div, id: 'error_explanation') do
      safe_join [content_tag(:h3, formatted_sentence),
                 content_tag(:ul, safe_join(full_messages_in_li))]
    end
  end

  def full_messages_in_li
    resource.errors.full_messages.map do |msg|
      content_tag(:li, msg)
    end
  end

  def formatted_sentence
    I18n.t('errors.messages.not_saved',
           count: resource.errors.count,
        resource: resource.class.model_name.human.downcase)
  end
end
