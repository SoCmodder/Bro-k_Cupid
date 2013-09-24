class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  attr_accessible :email, :first_name, :last_name, :name

  validates(:name, presence: true)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false})
end
