class Answer < ActiveRecord::Base
  after_commit :fill_alchemy_keywords_and_sentiment

  has_one :alchemy

  private

    def fill_alchemy_keywords_and_sentiment
      keywords = AlchemyAPI.search(:keyword_extraction, text: self.answer)
      sentiment = AlchemyAPI.search(:sentiment_analysis, text: self.answer)
      Alchemy.create!(answer_id: self.id, keywords: keywords, sentiment: sentiment)
    end
end
