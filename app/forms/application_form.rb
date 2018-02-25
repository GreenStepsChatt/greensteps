class ApplicationForm
  include ActiveModel::Model

  def self.validate_models(*reader_names)
    validate do
      models = reader_names.map { |name| send(name) }
      models.each do |model|
        promote_errors(model.errors) if model.invalid?
      end
    end
  end

  def promote_errors(child_errors)
    child_errors.each do |attribute, message|
      errors.add(attribute, message)
    end
  end

  def save
    if valid?
      save!
    else
      false
    end
  end
end
