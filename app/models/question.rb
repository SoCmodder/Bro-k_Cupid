class Question < ActiveRecord::Base
  attr_accessible :text
  has_one :user_answer

  #scope :without_answered, lambda { where('id !=') }
end
