class AddAthenaHealthPatientIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :patient_id, :integer
  end
end
