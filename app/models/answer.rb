class Answer < ApplicationRecord
  has_one :alchemy
  belongs_to :question
end
