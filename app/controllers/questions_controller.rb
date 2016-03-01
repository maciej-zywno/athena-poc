class QuestionsController < ApplicationController
  def index
    @treatment = Treatment.find(params[:treatment_id])
    @questions = @treatment.questions
  end

  def show
    @question = Question.find(params[:id])
  end
end
