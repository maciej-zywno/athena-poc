class Answer < ActiveRecord::Base
  after_create :alchemy

  has_one :fill_alchemy_keywords_and_sentiment

  private

    def fill_alchemy_keywords_and_sentiment
      self.keywords = AlchemyAPI.search(:keyword_extraction, text: self.answer)
      self.sentiment = AlchemyAPI.search(:sentiment_analysis, text: self.answer)
    end
end
