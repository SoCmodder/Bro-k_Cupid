class AddAnswerToUserAnswers < ActiveRecord::Migration
  def change
    add_column :user_answers, :answer, :string
  end
end
