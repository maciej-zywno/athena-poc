class Answer < ActiveRecord::Base
  after_commit :process_answer

  has_one :alchemy
  belongs_to :question

end
