class RenameTreatmentsToGames < ActiveRecord::Migration[5.0]
  def change
    rename_table :treatments, :games
  end
end
