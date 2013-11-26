class Event < ActiveRecord::Base
  belongs_to :host, :class_name => "User"
  has_many :reservations

  attr_accessible :description, :location, :title, :day, :time

  #default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :location, presence: true, length: { maximum: 50 }
  
  #validates :host_id, presence: true
end
