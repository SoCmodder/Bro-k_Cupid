class Post < ActiveRecord::Base
  attr_accessible :content, :user_id
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true

  # Returns posts from friends of the given user.
  def self.from_friends(user)
    friend_ids = "SELECT friend_id
                  FROM friendships
                  WHERE user_id = :user_id"

    friended_ids = "SELECT user_id
                    FROM friendships
                    WHERE friend_id = :user_id"

    where("user_id IN (#{friend_ids}) OR user_id in (#{friended_ids}) OR user_id = :user_id",
         user_id: user.id)



  end
end
