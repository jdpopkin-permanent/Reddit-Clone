class User < ActiveRecord::Base
  attr_accessible :password, :username
  validates :username, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :password_digest, presence: true

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    return nil unless user.is_password?(password)
    user
  end
end
