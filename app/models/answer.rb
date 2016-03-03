class Answer < ActiveRecord::Base
  after_create_commit { AnswerBroadcastWorker.perform_async(id) }

  has_one :alchemy
  belongs_to :question
end
