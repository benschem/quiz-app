class AddUniqueIndexToGuesses < ActiveRecord::Migration[7.1]
  def change
    add_index :guesses, [:user_id, :answer_id], unique: true, name: 'index_guesses_on_user_and_answer'
  end
end
