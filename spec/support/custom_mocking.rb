module CustomMocking
  def temp_set(attribute_name, value)
    original_value = send(attribute_name)
    send("#{attribute_name}=", value)
    yield.tap { send("#{attribute_name}=", original_value) }
  end
end

ApplicationRecord.include CustomMocking
