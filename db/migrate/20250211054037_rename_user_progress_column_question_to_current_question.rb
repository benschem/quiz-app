class RenameUserProgressColumnQuestionToCurrentQuestion < ActiveRecord::Migration[7.1]
  def change
    rename_column :user_progresses, :question_id, :current_question_id
  end
end
