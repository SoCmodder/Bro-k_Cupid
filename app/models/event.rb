class Event < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :location, :title, :user_id
  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :location, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
end
