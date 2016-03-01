class AddThresholdsToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :low_threshold, :integer
    add_column :questions, :high_threshold, :integer
  end
end
