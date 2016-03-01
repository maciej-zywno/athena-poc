class FetchAlchemyKeywordsAndSentimentService
  def call(answer)
    {
      keywords: AlchemyAPI.search(:keyword_extraction, text: answer.answer),
      sentiment: AlchemyAPI.search(:sentiment_analysis, text: answer.answer)
    }
  end
end
