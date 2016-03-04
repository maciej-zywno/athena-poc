class NotifyDoctorService
  def call(answer)
    if ENV['SMS_ENABLED'] == 'true'
      SendTextMessageService.new.call(answer.question.treatment.doctor.phone_number, build_text(answer))
    end
  end

  private

    def build_text(answer)
      if answer.question.string?
        build_string_type_question_text(answer)
      elsif answer.question.number?
        build_number_type_question_text(answer)
      else
        raise "unsupported answer type '#{answer.question.answer_type}'"
      end
    end

    def build_string_type_question_text(answer)
      patient = answer.question.treatment.patient
      "Patient #{patient.name} | Risky keyword found #{answer.alchemy.keywords.map{|e| e['text']}} (configured: #{answer.question.risky_keywords})"
    end

    def build_number_type_question_text(answer)
      patient = answer.question.treatment.patient
      "Patient #{patient.name} answer #{answer.answer} to question #{answer.question.question} outside of threshold: LOW=#{answer.question.low_threshold} HIGH=#{answer.question.high_threshold}})"
    end
end
