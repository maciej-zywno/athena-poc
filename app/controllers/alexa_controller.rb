class AlexaController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def handle
    request_body = request.body.read.to_s
    verify_correct_alexa_request!(request_body)
    request_body_parsed = JSON.parse(request_body)
    log_request(request_body_parsed)

    render text: handle_alexa_request(request_body_parsed, AlexaRubykit.build_request(request_body_parsed))
  end

  def handle_alexa_request(request_body_parsed, request)
    return handle_launch_request(request_body_parsed, request) if (request.type == 'LAUNCH_REQUEST')
    return handle_intent_request(request) if (request.type == 'INTENT_REQUEST')
    return handle_session_ended_request(request) if (request.type =='SESSION_ENDED_REQUEST')

    raise "unsupported request type #{request.type}"
  end

  private

    def handle_session_ended_request(request)
      response = AlexaRubykit::Response.new
      logger.info "request.type=#{request.type}"
      logger.info "request.reason=#{request.reason}"
      response.build_response
    end

    def handle_intent_request(request)
      logger.info "request.type=#{request.type}"
      logger.info "request.slots=#{request.slots}"
      logger.info "request.name=#{request.name}"

      # response.add_session_attribute('questions', question_id_and_questions_pairs)
      # response.add_session_attribute('answered_questions', [])
      # response.add_session_attribute('current_question', first_question[0])

      # logger.info

      # add current answer to answered_questions
      current_answered_questions = request.session.attributes['answered_questions']
      current_question_id, current_question_text = request.session.attributes['current_question']
      current_question_answer = request.slots['Answer']['value']
      new_answered_questions = current_answered_questions << [current_question_id, current_question_answer]
      request.session.attributes['answered_questions'] = new_answered_questions

      response = AlexaRubykit::Response.new
      next_question = any_not_answered_question(request.session.attributes['questions'], request.session.attributes['answered_questions'])
      response.add_speech(next_question)
      response.add_session_attribute('current_question', next_question)

      response.build_response(session_end = all_questions_answered?(request.session.attributes['questions'], request.session.attributes['answered_questions']))
    end

    def handle_launch_request(request_body_parsed, request)
      logger.info "request=#{request.class}"
      logger.info "request=#{request.inspect}"
      logger.info "request.type=#{request.type}"
      logger.info "request.attributes=#{request_body_parsed}"

      logger.info 'FIND USER BY AMAZON USER ID'
      user = User.find_by_amazon_user_id(request_body_parsed['session']['user']['userId'])

      logger.info 'FIND TREATMENT QUESTIONS'
      # [[4, "On a scale 1 to 10 how bad is your back today?"], [1, "How do you feel today?"]]
      question_id_and_questions_pairs = Treatment.last.questions.pluck(:id, :question)
      logger.info "QUESTION_ID_AND_QUESTIONS_PAIRS: #{question_id_and_questions_pairs.inspect}"
      next_question = question_id_and_questions_pairs[0]

      response = AlexaRubykit::Response.new
      response.add_speech(next_question[1])

      response.add_session_attribute('questions', question_id_and_questions_pairs)
      response.add_session_attribute('answered_questions', [])
      response.add_session_attribute('current_question', [next_question[0], next_question[1]])

      response.build_response(session_end = false)
    end

    def verify_correct_alexa_request!(request_body)
      verification_result = AlexaVerifier.new.verify!(
        request.headers['SignatureCertChainUrl'],
        request.headers['Signature'],
        request_body
      )

      logger.info "verification_result=#{verification_result}"
    end

    def log_request(request_body)
      logger.info '!!! ALEXA REQUEST BODY !!!'

      logger.info request_body.to_json
      logger.info "request.headers['SignatureCertChainUrl']=#{request.headers['SignatureCertChainUrl']}"
      logger.info "request.headers['Signature']=#{request.headers['Signature']}"

      logger.info '!!! ALEXA END !!!'
    end

    # all_questions: [[4, "On a scale 1 to 10 how bad is your back today?"], [1, "How do you feel today?"]]
    # answered_questions: [[1, "foo"], [4, "bar"]]
    def all_questions_answered?(all_questions, answered_questions)
      logger.info "!!! ALL_QUESTIONS_ANSWERED? !!!"
      logger.info "all_questions=#{all_questions.inspect}"
      logger.info "answered_questions=#{answered_questions.inspect}"
    end

    def any_not_answered_question(all_questions, answered_questions)
      return false
    end

end

