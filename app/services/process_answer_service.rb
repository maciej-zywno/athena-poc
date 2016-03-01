class ProcessAnswerService
  def call(answer)
    if answer.question.string?
      answer.create_alchemy!(FetchAlchemyKeywordsAndSentimentService.new.call(answer))
      NotifyDoctorService.new.call(answer) if contains_risky_keywords_or_negative_sentiment?(answer)
    elsif answer.question.number?
      NotifyDoctorService.new.call(answer) if contains_risky_value?(answer)
    else
      raise "unsupported answer type '#{answer.question.answer_type}'"
    end
  end

  private

    def contains_risky_keywords_or_negative_sentiment?(answer)
      answer.question.risky_keywords.any?{|risky_keyword|
        answer.alchemy.keywords.any?{|keyword| keyword['text'].include?(risky_keyword)}
      }
    end

    def contains_risky_value?(answer)
      answer.answer.to_i < answer.question.low_threshold || answer.answer.to_i > answer.question.high_threshold
    end

end
