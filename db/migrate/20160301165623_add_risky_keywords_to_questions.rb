class AddRiskyKeywordsToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :risky_keywords, :text, array:true, default: []
  end
end
