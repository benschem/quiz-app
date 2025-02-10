class UpdateTimesGuessedDefaultToZeroAnswers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :answers, :times_guessed, from: nil, to: 0
  end
end
