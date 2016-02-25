class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatments do |t|
      t.integer :patient_id, null: false
      t.integer :doctor_id, null: false

      t.timestamps null: false
    end
  end
end
