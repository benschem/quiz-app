class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.references :question, null: false, foreign_key: true
      t.string :text
      t.boolean :correct
      t.integer :times_guessed, default: 0

      t.timestamps
    end
  end
end
