class QuestionsController < ApplicationController

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Question Created"
      redirect_to root_url
    else
      flash[:error] = "Unable to create question. Please try again later."
      redirect_to root_url
    end
  end

  def index
    @questions = Question.paginate(page: params[:page])
  end

  private

  def question_params
    params.require(:question).permit(:text)
  end
end
