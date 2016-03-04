class QuestionsController < ApplicationController
  before_action :set_game
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    @questions = @game.questions
  end

  def show
    @question = @game.questions.find(params[:id])
    authorize @question
  end

  def new
    @question = @game.questions.build
    authorize @question
  end

  def create
    @question = @game.questions.build(risky_keywords_as_array(question_params))
    authorize @question

    if @question.save
      redirect_to game_questions_path(@game), success: 'Question created succesfully'
    else
      render :new
    end
  end

  def update
    authorize @question

    @question.risky_keywords_will_change!
    if @question.update(risky_keywords_as_array(question_params))
      redirect_to game_questions_path(@game), success: 'Question updated succesfully'
    else
      render :edit
    end
  end

  def destroy
    authorize @question

    @question.destroy
    redirect_to game_questions_path(@game), notice: 'Question destroyed succesfully'
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_question
    @question = @game.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:question, :answer_type, :low_threshold, :high_threshold, :risky_keywords)
  end

  def risky_keywords_as_array(question_params)
    question_params.merge(risky_keywords: to_array(question_params['risky_keywords']))
  end

  def to_array(risky_keywords_as_string)
    [""]#risky_keywords_as_string.split(',').map(&:strip)
  end
end
