class QuestionBroadcastJob < ApplicationJob
  queue_as :process_answer

  def perform(question)
    ActionCable.server.broadcast "question#{question.id}", question_data: render_question_answers(question)
  end

  private

  def render_question_answers(question)
    ApplicationController.renderer.render(partial: 'questions/question_data', locals: { question: question } )
  end
end
