class UserAnswer < ActiveRecord::Base
  attr_accessible :answer_id, :importance, :question_id, :user_id
  belongs_to :user
  belongs_to :question
  validates :answer_id, presence: true
  validates :importance, presence: true
  validates :question_id, presence: true
  validates :user_id, presence: true
end
