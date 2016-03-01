class QuestionsController < ApplicationController
  before_action :set_treatment
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    @questions = @treatment.questions
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = @treatment.questions.build
  end

  def create
    @question = @treatment.questions.build(question_params)
    if @question.save
      redirect_to treatment_questions_path(@treatment), success: 'Question created succesfully'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to treatment_questions_path(@treatment), success: 'Question updated succesfully'
    else
      render :edit
    end
  end

  def destroy
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
    params.require(:question).permit(:question, :answer_type)
  end
end
