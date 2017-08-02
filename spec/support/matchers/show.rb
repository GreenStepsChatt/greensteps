RSpec::Matchers.define :show do |page_object_name|
  match do |_page|
    page_object.on_page? && page_object.visible?
  end

  match_when_negated do |_page|
    !page_object.on_page? || page_object.hidden?
  end

  define_method :page_object do
    send(page_object_name, true)
  end
end
