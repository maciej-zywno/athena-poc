class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatments do |t|
      t.integer :patient_id
      t.integer :doctor_id

      t.timestamps null: false
    end
  end
end
