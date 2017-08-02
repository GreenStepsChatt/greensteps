require_relative 'not_found'
require_relative 'base'

Dir["#{__dir__}/**/*.rb"].each { |f| require f }

module PageObjects
  def method_missing(method_name, *args, &block)
    po_class_name = class_name_for(method_name)
    if valid_po_class?(po_class_name)
      po_class_name.constantize.new(*args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method_name, _include_private = false)
    valid_po_class? class_name_for(method_name)
  end

  private

  def class_name_for(method_name)
    "PageObjects::#{method_name.to_s.classify}"
  end

  def valid_po_class?(class_name)
    Base.descendants.map(&:name).include? class_name
  end
end
