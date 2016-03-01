class ProcessAnswerWorker
  # include Sidekiq::Worker

  # sidekiq_options queue: :process_answer, retry: false

  def perform(answer_id)
    ProcessAnswerService.new.call(Answer.find(answer_id))
  end
end
