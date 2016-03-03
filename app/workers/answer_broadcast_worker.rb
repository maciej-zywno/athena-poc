class AnswerBroadcastWorker
  include Sidekiq::Worker

  sidekiq_options queue: :process_answer, retry: false

  def perform(answer_id)
    answer = Answer.find(answer_id)

    ActionCable.server.broadcast "question#{answer.question_id}", answer: render_answer(answer)
  end

  private

  def render_answer(answer)
    ApplicationController.renderer.render(partial: 'answers/answer', locals: { answer: answer } )
  end
end