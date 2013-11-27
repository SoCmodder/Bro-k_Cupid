class AddIndexToUserAnswers < ActiveRecord::Migration
  def change
      add_index :user_answers, [:user_id, :question_id], :unique => true
  end
end
