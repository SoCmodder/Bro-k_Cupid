class RemoveAnswersFromQuestions < ActiveRecord::Migration
  def up
    remove_column :questions, :ans1
    remove_column :questions, :ans2
    remove_column :questions, :ans3
    remove_column :questions, :ans4
    remove_column :questions, :ans5
  end

  def down
    add_column :questions, :ans5, :string
    add_column :questions, :ans4, :string
    add_column :questions, :ans3, :string
    add_column :questions, :ans2, :string
    add_column :questions, :ans1, :string
  end
end
