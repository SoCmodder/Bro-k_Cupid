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
    @user = current_user
    @user_answer = @user.user_answers.new(:user_id=>@user.id)
  end

  private

  def question_params
    params.require(:question).permit(:text)
  end
end
