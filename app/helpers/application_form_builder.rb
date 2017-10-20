class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, to: :@template

  def number_field(*args)
    super + quantity_nav
  end

  def quantity_nav
    content_tag :div, class: 'quantity-nav' do
      content_tag(:div, '+', class: 'quantity-button quantity-up') +
        content_tag(:div, '-', class: 'quantity-button quantity-down')
    end
  end
end
