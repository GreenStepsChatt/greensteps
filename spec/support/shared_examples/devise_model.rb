RSpec.shared_examples 'a devise model' do
  it { should respond_to :email }
  it { should respond_to :encrypted_password }
  it { should respond_to :reset_password_token }
  it { should respond_to :reset_password_sent_at }
  it { should respond_to :remember_created_at }
  it { should respond_to :sign_in_count }
  it { should respond_to :current_sign_in_at }
  it { should respond_to :last_sign_in_at }
  it { should respond_to :current_sign_in_ip }
  it { should respond_to :last_sign_in_ip }

  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of :password }
  it { should validate_length_of(:password).is_at_least(6).is_at_most(128) }
  it { should allow_value('user@example.com').for(:email) }
  it { should_not allow_values('user', 'user@', '@example.com').for(:email) }
end
