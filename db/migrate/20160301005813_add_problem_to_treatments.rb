class AddProblemToTreatments < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :problem, :string, null: false, default: ''
  end
end
