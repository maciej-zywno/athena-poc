class AlexaController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def handle
    Alexa::Verifier.verify(headers: request.headers, body: request.body.read)
    request_body = request.body.read.to_s
    request_body_parsed = JSON.parse(request_body)
    log_request(request_body_parsed)

    render text: handle_alexa_request(request_body_parsed, AlexaRubykit.build_request(request_body_parsed))
  end

  def handle_alexa_request(request_body, request)
    case request.type
      when 'LAUNCH_REQUEST' then process_alexa_request(*Alexa::LaunchRequestWrapper.new(request_body, request).process)
      when 'INTENT_REQUEST' then process_alexa_request(*Alexa::IntentRequestWrapper.new(request_body, request).process)
      when 'SESSION_ENDED_REQUEST' then process_alexa_request(nil, {}, true)
      else raise "unsupported request type #{request.type}"
    end
  end

  private

    def process_alexa_request(speech, session_attributes, session_end)
      response = AlexaRubykit::Response.new
      response.add_speech(speech) if speech
      session_attributes.each { |k, v|
        response.add_session_attribute(k, v)
      }

      response = response.build_response(session_end)

      logger.info "---------------------------------------------------"
      logger.info "---------------------------------------------------"
      logger.info "---------------------------------------------------"
      logger.info "speech=#{speech}"
      logger.info "session_attributes=#{session_attributes}"
      logger.info response.inspect
      response
    end

    def log_request(request_body)
      logger.info '!!! ALEXA REQUEST BODY !!!'

      logger.info request_body.to_json
      logger.info "request.headers['SignatureCertChainUrl']=#{request.headers['SignatureCertChainUrl']}"
      logger.info "request.headers['Signature']=#{request.headers['Signature']}"

      logger.info '!!! ALEXA END !!!'
    end

end

