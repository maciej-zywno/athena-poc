class RenameGameProblemToName < ActiveRecord::Migration[5.0]
  def change
    rename_column :games, :problem, :name
  end
end
