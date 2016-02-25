class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :treatment_id, null: false
      t.string :question, null: false

      t.timestamps null: false
    end
  end
end
