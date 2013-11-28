class UserAnswersController < ApplicationController
  def new
    @user_answer = UserAnswer.new
  end

  def create
    #@user_answer = UserAnswer.new(user_answer_params)
    @user_answer = current_user.user_answers.build(params[:user_answer])
    if @user_answer.save
      flash[:success] = "Question Answered!"
    else
      flash[:error] = "Could not submit answer. Pleast try again."
    end
  end

  private

  def user_answer_params
    params.require(:user_answer).permit(:answer_id, :importance, :question_id, :user_id)
  end
end
