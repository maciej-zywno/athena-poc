class TextMessagesController < ApplicationController
  def create
    number_to_send_to = params[:text_message][:phone_number]
    text = "This is an message. It gets sent to #{number_to_send_to}"

    if ENV['SMS_ENABLED'] == 'true'
      SendTextMessageService.new.call(number_to_send_to, text)
    end

    redirect_to :back
  end

end
