RSpec::Matchers.define :validate_models do |*model_names|
  match do |form|
    raise StandardError, <<~TEXT if form.invalid?
      in "validate_models" matcher, subject must be valid
    TEXT
    @form = form
    @model_names = model_names
    validated_models == model_names
  end

  define_method :validated_models do
    @validated_models ||= @model_names.select do |model_name|
      model = @form.send(model_name)
      model.temp_set(:attributes, invalid_attributes_for(model_name)) do
        @form.invalid?
      end
    end
  end

  define_method :invalid_attributes_for do |model_name|
    begin
      attributes_for model_name, :invalid
    rescue ArgumentError => e
      raise ArgumentError, <<~TEXT if e.message.include? 'Trait not registered'
        the "validate_models" matcher requires each model's factory to have
        an "invalid" trait
      TEXT
      raise
    end
  end

  failure_message do |form|
    <<~TEXT
      expected #{form} to validate #{@model_names.to_sentence} models, but
      #{results_in_words}
    TEXT
  end

  def results_in_words
    if validated_models.empty?
      'no models were validated'
    else
      "only #{validated_models.to_sentence} "\
      "#{validated_models.size == 1 ? 'was' : 'were'} validated"
    end
  end
end
