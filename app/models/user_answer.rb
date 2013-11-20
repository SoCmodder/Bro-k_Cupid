class UserAnswer < ActiveRecord::Base
  attr_accessible :answer_id, :importance, :question_id, :user_id
end
