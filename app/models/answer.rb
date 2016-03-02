class Answer < ActiveRecord::Base
  has_one :alchemy
  belongs_to :question
end
