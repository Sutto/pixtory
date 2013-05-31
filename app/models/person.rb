class Person < ActiveRecord::Base

  before_validation :generate_authentication_token
  validates         :push_token, :authentication_token, presence: true, uniqueness: true

  def self.create_with_push_token!(push_notification_token)
    create! push_token: push_notification_token.to_s
  end

  protected

  def generate_authentication_token
    self.authentication_token ||= SecureRandom.hex(64)
  end

end
