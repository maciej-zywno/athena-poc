class SendTextMessageService
  def call(number, text)
    twilio_client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH']


    message = twilio_client.account.messages.create(
        from: ENV['TWILIO_FROM_PHONE'],
        to: number,
        body: text
    )

    Rails.logger.info "SENT TWILIO #{message.inspect}"
  end
end
