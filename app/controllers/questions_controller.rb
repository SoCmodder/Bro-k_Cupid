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
      flash[:success] = "That's a totally chill topic, dude!"
      redirect_to root_url
    else
      flash[:error] = "Sorry man, we couldn't create that topic at this time. Maybe hit the gym and try again later."
      redirect_to root_url
    end
  end


  def index
    @questions = Question.paginate(page: params[:page])
    @user = current_user
    @user_answer = @user.user_answers.new(:user_id => @user.id)
  end

  private

  def question_params
    params.require(:question).permit(:text)
  end
end
