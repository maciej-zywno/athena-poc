# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class QuestionChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    stream_from "question#{data['question_id']}"
  end

  def unfollow
    stop_all_streams
  end
end
