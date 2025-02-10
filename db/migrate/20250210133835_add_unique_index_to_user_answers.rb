class AddUniqueIndexToUserAnswers < ActiveRecord::Migration[7.1]
  def change
    add_index :user_answers, [:session_id, :answer_id], unique: true, name: 'index_user_answers_on_session_and_answer'
  end
end
