class AddUserQuizToGuesses < ActiveRecord::Migration[7.1]
  def change
    add_column :guesses, :user_quiz_id, :bigint, null: false
    add_index :guesses, :user_quiz_id
    add_foreign_key :guesses, :user_quizzes
  end
end
