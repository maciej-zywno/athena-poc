class Question < ActiveRecord::Base
  enum answer_type: [ string: 0, number: 1 ]

  has_many :answers
  belongs_to :treatment
end
