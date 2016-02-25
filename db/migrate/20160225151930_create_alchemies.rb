class CreateAlchemies < ActiveRecord::Migration
  def change
    create_table :alchemies do |t|
      t.integer :answer_id, null: false
      t.json :keywords
      t.json :sentiment

      t.timestamps null: false
    end
  end
end
