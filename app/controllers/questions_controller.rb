class QuestionsController < ApplicationController
  before_action :set_treatment
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    @questions = @treatment.questions
  end

  def show
    @question = @treatment.questions.find(params[:id])
    authorize @question
  end

  def new
    @question = @treatment.questions.build
    authorize @question
  end

  def create
    @question = @treatment.questions.build(risky_keywords_as_array(question_params))
    authorize @question

    if @question.save
      redirect_to treatment_questions_path(@treatment), success: 'Question created succesfully'
    else
      render :new
    end
  end

  def update
    authorize @question

    @question.risky_keywords_will_change!
    if @question.update(risky_keywords_as_array(question_params))
      redirect_to treatment_questions_path(@treatment), success: 'Question updated succesfully'
    else
      render :edit
    end
  end

  def destroy
    authorize @question

    @question.destroy
    redirect_to treatment_questions_path(@treatment), notice: 'Question destroyed succesfully'
  end

  private

  def set_treatment
    @treatment = Treatment.find(params[:treatment_id])
  end

  def set_question
    @question = @treatment.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:question, :answer_type, :low_threshold, :high_threshold, :risky_keywords)
  end

  def risky_keywords_as_array(question_params)
    question_params.merge(risky_keywords: to_array(question_params['risky_keywords']))
  end

  def to_array(risky_keywords_as_string)
    risky_keywords_as_string.split(',').map(&:strip)
  end
end
