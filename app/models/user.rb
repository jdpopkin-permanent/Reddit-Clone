class User < ActiveRecord::Base
  attr_accessible :password, :username
  validates :username, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :password_digest, presence: true

  has_many :user_votes, class_name: "UserVote", primary_key: :id,
          foreign_key: :user_id

  has_many :votes, through: :user_votes, source: :link, inverse_of: :voters

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    return nil unless user && user.is_password?(password)
    user
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!
  end
end
