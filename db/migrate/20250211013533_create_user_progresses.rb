class CreateUserProgresses < ActiveRecord::Migration[7.1]
  def change
    create_table :user_progresses do |t|
      t.references :quiz, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.boolean :completed
      t.string :session_id

      t.timestamps
    end
  end
end
