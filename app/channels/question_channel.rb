# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class QuestionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "question_channel"
  end

  def unsubscribed
  end

  def follow(data)
    ActionCable.server.broadcast 'question_channel', message: data['message']
  end

  def unfollow
  end
end
