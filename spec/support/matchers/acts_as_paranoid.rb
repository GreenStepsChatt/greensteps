RSpec::Matchers.define :act_as_paranoid do
  match do |user|
    user.attributes = attributes_for(:user)
    user.save!
    user.destroy
    user.persisted? && !User.exists?(id: user.id)
  end
end
