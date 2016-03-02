class AlexaController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def handle
    Alexa::Verifier.verify(headers: request.headers, body: request.body.read)
    avsmetrics(request.body.read)

    request_body = request.body.read.to_s
    request_body_parsed = JSON.parse(request_body)
    log_request(request_body_parsed)

    render text: handle_alexa_request(request_body_parsed, AlexaRubykit.build_request(request_body_parsed))
  end

  def handle_alexa_request(request_body, request)
    case request.type
      when 'LAUNCH_REQUEST' then alexa_response(*Alexa::LaunchRequestWrapper.new(request_body, request).process)
      when 'INTENT_REQUEST' then alexa_response(*Alexa::IntentRequestWrapper.new(request_body, request).process)
      when 'SESSION_ENDED_REQUEST' then alexa_response(nil, {}, true)
      else raise "unsupported request type #{request.type}"
    end
  end

  private

    def alexa_response(speech, session_attributes, session_end)
      response = AlexaRubykit::Response.new
      response.add_speech(speech) if speech
      session_attributes.each { |k, v|
        response.add_session_attribute(k, v)
      }
      response.build_response(session_end)
    end

    def log_request(request_body)
      logger.info '!!! ALEXA REQUEST BODY !!!'
      logger.info request_body.to_json
      logger.info '!!! ALEXA END !!!'
    end

    def avsmetrics(json)
      require 'net/http'
      require 'uri'

      token = 'monarch-health-token-1'
      url = "http://avsmetrics.herokuapp.com/alexa?token=#{token}"
      uri = URI.parse(url)

      request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' =>'application/json')
      request.body = json
      http = Net::HTTP.new(uri.host, uri.port)
      resp = http.request(request)
    end
end

