RSpec::Matchers.define :be_deleted_from_storage do
  match do |attachment|
    !ActiveStorage::Blob.service.exist?(attachment.blob.key)
  end
end
