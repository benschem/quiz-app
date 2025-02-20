class AddHighScoreAndTimesTakenToUserQuizzes < ActiveRecord::Migration[7.1]
  def change
    add_column :user_quizzes, :high_score, :integer, default: 0
    add_column :user_quizzes, :times_taken, :integer, default: 0
  end
end
