class Answer < ActiveRecord::Base
  after_create_commit { QuestionBroadcastJob.perform_later(self.question) }

  has_one :alchemy
  belongs_to :question
end
