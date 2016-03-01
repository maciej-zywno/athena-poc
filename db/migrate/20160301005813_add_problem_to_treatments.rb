class AddProblemToTreatments < ActiveRecord::Migration[5.0]
  def change
    add_column :treatments, :problem, :string, null: false, default: ''
  end
end
