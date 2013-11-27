class RemoveAnswerIdFromUserAnswers < ActiveRecord::Migration
  def up
    remove_column :user_answers, :answer_id
  end

  def down
    add_column :user_answers, :answer_id, :string
  end
end
