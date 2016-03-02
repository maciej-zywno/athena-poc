class AlexaController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def handle
    request_body = JSON.parse(request.body.read.to_s)
    verify_correct_alexa_request!(request_body)
    log_request(request_body)

    logger.info 'FIND USER BY AMAZON USER ID'
    user = User.find_by_amazon_user_id(request_body['session']['user']['userId'])
    logger.info user.inspect

    alexa_request = AlexaRubykit.build_request(request_body)
    render text: handle_alexa_request(alexa_request)
  end

  def handle_alexa_request(request)
    return handle_launch_request(request) if (request.type == 'LAUNCH_REQUEST')
    return handle_intent_request(request) if (request.type == 'INTENT_REQUEST')
    return handle_session_ended_request(request) if (request.type =='SESSION_ENDED_REQUEST')

    raise "unsupported request type #{request.type}"
  end

  private

    QUESTION_1 = 'Hello! Do you feel better then yesterday?'
    QUESTION_2 = 'How do you feel today?'
    QUESTION_3 = 'Did you take all your medications today?'

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

      next_question = next_question(request.session.attributes['current_question'])

      response = AlexaRubykit::Response.new
      response.add_speech(next_question)
      response.add_session_attribute('current_question', next_question)
      response.add_session_attribute(request.session.attributes['current_question'], request.slots['Answer']['value'])
      response.build_response(next_question.nil?)
    end

    def handle_launch_request(request)
      logger.info "request.type=#{request.type}"
      response = AlexaRubykit::Response.new
      response.add_speech(QUESTION_1)
      response.add_session_attribute('current_question', QUESTION_1)
      response.build_response(session_end = false)
    end

    def next_question(current_question)
      case current_question
        when QUESTION_1 then return QUESTION_2
        when QUESTION_2 then return QUESTION_3
      end
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
end

