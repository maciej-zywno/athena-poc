class AddAnswerTypeToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :answer_type, :integer, null: false, default: 0
  end
end
