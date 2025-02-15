class AddScoreAndTimesTakenToUserQuizzes < ActiveRecord::Migration[7.1]
  def change
    add_column :user_quizzes, :high_score, :integer
    add_column :user_quizzes, :times_taken, :integer
  end
end
