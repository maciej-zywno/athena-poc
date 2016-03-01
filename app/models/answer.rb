class Answer < ActiveRecord::Base
  after_commit :fill_alchemy_keywords_and_sentiment, if: Proc.new { |answer| answer.question.string? }


  has_one :alchemy
  belongs_to :question

  private

    def fill_alchemy_keywords_and_sentiment
      keywords = AlchemyAPI.search(:keyword_extraction, text: self.answer)
      sentiment = AlchemyAPI.search(:sentiment_analysis, text: self.answer)
      Alchemy.create!(answer_id: self.id, keywords: keywords, sentiment: sentiment)
    end
end
