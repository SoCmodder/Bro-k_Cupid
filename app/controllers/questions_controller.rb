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
    end
  end

  def index
    @questions = Question.paginate(page: params[:page])
  end

  private

    def question_params
      params.require(:question).permit(:text, :ans1, :ans2, :ans3, :ans4, :ans5)
    end
end
