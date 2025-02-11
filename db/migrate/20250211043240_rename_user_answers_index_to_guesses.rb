class RenameUserAnswersIndexToGuesses < ActiveRecord::Migration[7.1]
  def change
    rename_index :guesses, "index_user_answers_on_session_and_answer", "index_guesses_on_session_and_answer"
  end
end
