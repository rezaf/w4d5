class User < ActiveRecord::Base
  after_initialize :ensure_session_token
  
  validates :user_name, :password_digest, presence: true
  validates :user_name, uniqueness: true
  
  attr_reader :password
  
  has_many(
    :subs,
    class_name: "Sub",
    foreign_key: :moderator_id,
    primary_key: :id
  )
  
  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    
    user && user.is_password?(password) ? user : nil
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password).to_s
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def reset_session_token!
    self.session_token = generate_unique_token_for_field(:session_token)
    self.save!
    self.session_token
  end
  
  def ensure_session_token
    self.session_token ||= generate_unique_token_for_field(:session_token)
  end
  
  def generate_unique_token_for_field(field)
    begin
      session_token = SecureRandom.base64(16)
    end until !self.class.exists?(field => session_token)
    
    session_token
  end
  
end
