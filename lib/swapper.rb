# Use this to set an object's property only for the duration of a block.
#
# Example:
#   Suppose you want a rake task to create some users and you don't want emails
#   to be delivered when the users are created (in our dev. environment this
#   opens up a bunch of browser windows because we use "letter_opener"):
#
#   ```ruby
#     task :create_users do
#       Swapper.while(ActionMailer::Base).has(:perform_deliveries).
#         set_to(false) do
#           # create some users
#         end
#     end
#   ```
#
# The object you send to `while` can be any Ruby that has an attr_reader and
# attr_writer for the attribute you specify when calling `has`.
#
# Obviously, don't mix this module into something because `while` is a keyword.
# If you think of a better name than "while" let me know!
module Swapper
  class Base
    attr_reader :object, :attribute_name

    def initialize(object)
      @object = object
    end

    # attribute_name should be the attr_reader (and attr_writer w/out equals
    # sign)
    def has(attribute_name)
      @attribute_name = attribute_name
      self
    end

    def set_to(value) # rubocop:disable Naming/AccessorMethodName
      original_value = object.send(attribute_name)
      object.send("#{attribute_name}=", value)
      yield.tap { object.send("#{attribute_name}=", original_value) }
    end
  end

  def self.while(object)
    Base.new(object)
  end
end
