RSpec::Matchers.define :include_record_with do |attributes|
  match do |relation|
    relation.exists?(attributes)
  end
end
