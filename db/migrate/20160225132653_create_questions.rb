class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :treatment_id
      t.string :question

      t.timestamps null: false
    end
  end
end
