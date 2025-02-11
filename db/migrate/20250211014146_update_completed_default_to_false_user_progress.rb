class UpdateCompletedDefaultToFalseUserProgress < ActiveRecord::Migration[7.1]
  def change
    change_column_default :user_progresses, :completed, from: nil, to: false
  end
end
