class SendTextMessageService
  def call(number, text)
    twilio_client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH']

    twilio_client.account.messages.create(
        from: ENV['TWILIO_FROM_PHONE'],
        to: number,
        body: text
    )
  end
end
