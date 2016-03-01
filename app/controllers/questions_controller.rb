class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @question = Question.find(params[:id])
  end

end
