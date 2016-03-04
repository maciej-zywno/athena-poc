class Alexa::RequestWrapper
  def initialize(plain_request_body, alexa_request)
    @plain_request_body = plain_request_body
    @alexa_request = alexa_request

    Rails.logger.info "request=#{alexa_request.inspect}"
    Rails.logger.info "request.type=#{alexa_request.type}"
    Rails.logger.info "request.attributes=#{plain_request_body}"
  end

  # @return [[4, "On a scale 1 to 10 how bad is your back today?"], [1, "How do you feel today?"]]
  def get_question_id_and_questions_pairs
    Rails.logger.info 'FIND USER BY AMAZON USER ID'
    user = User.find_by_amazon_user_id(@plain_request_body['session']['user']['userId'])

    Rails.logger.info 'FIND GAMES QUESTIONS'
    question_id_and_questions_pairs = user.games.last.questions.pluck(:id, :question)

    Rails.logger.info "QUESTION_ID_AND_QUESTIONS_PAIRS: #{question_id_and_questions_pairs.inspect}"
    question_id_and_questions_pairs
  end

  def get_request_answer_value
    case @plain_request_body['request']['intent']['name']
      when 'AnswerIntent' then @alexa_request.slots['Answer']['value']
      when 'AnswerOnlyIntent' then @alexa_request.slots['Answer']['value']
      when 'FreeTextAnswerIntent' then @alexa_request.slots['FreeTextAnswer']['value']
      else raise "unsupported intent name #{@plain_request_body['request']['intent']['name']}"
    end
  end

  def get_session_current_question
    @alexa_request.session.attributes['current_question']
  end

  def get_session_questions
    @alexa_request.session.attributes['questions']
  end

  def get_session_answered_questions
    @alexa_request.session.attributes['answered_questions']
  end

end