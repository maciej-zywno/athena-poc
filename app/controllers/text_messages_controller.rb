class TextMessagesController < ApplicationController
  def create
    number_to_send_to = params[:text_message][:phone_number]

    twilio_client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH']

    twilio_client.account.messages.create(
      from: ENV['TWILIO_FROM_PHONE'],
      to: number_to_send_to,
      body: "This is an message. It gets sent to #{number_to_send_to}"
    )

    redirect_to :back
  end
end
