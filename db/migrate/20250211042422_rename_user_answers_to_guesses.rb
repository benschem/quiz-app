class RenameUserAnswersToGuesses < ActiveRecord::Migration[7.1]
  def change
    rename_table :user_answers, :guesses
  end
end
