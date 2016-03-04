class RenameQuestionsTreatmentIdToGameId < ActiveRecord::Migration[5.0]
  def change
    rename_column :questions, :treatment_id, :game_id
  end
end
