class User < ActiveRecord::Base
  attr_reader :password
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  before_validation :set_session_token
  
  has_many :goals
  
  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    user.try { user.is_password?(password) ? user : nil }
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
  
  private
  def set_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
end