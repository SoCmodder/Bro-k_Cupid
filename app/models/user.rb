class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", dependent: :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :reservations, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :user_answers

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  attr_accessible :email, :first_name, :last_name, :name, :password, :password_confirmation
  validates(:name, presence: true, length: {maximum: 50})
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true,
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false})
  has_secure_password
  validates :password, length: {minimum: 6}

  scope :without_user, lambda { |user| user ? {:conditions => ["id != ?", user.id]} : {} }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Post.where("user_id = ?", id)
  end

  def friend_feed
    Post.from_friends(self)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

end
