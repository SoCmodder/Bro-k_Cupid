class UserAnswersController < ApplicationController

    def create
    logger.debug "Params: #{params.inspect}"
    if UserAnswer.exists?(:user_id=>params[:user_answer][:user_id], :question_id=>params[:user_answer][:question_id])
        flash[:notice] = "Exists"
        @user_answer = UserAnswer.where(:user_id => params[:user_answer][:user_id], :question_id => params[:user_answer][:question_id])[0]
        @user_answer[:answer] = params[:user_answer][:answer]
        @user_answer[:importance] = params[:user_answer][:importance]
    else
        flash[:notice] = "Does Not Exist"
        @user = User.find(params[:user_answer][:user_id])
        @user_answer = @user.user_answers.build(:user_id => params[:user_answer][:user_id], :question_id => params[:user_answer][:question_id], :answer => params[:user_answer][:answer], :importance => params[:user_answer][:importance])
    end
    logger.debug "User Answer: #{@user_answer.attributes.inspect}"
    if @user_answer.valid?
        if @user_answer.save
            flash[:notice] = "Thanks bro, got your answer"
            redirect_to questions_path
        else
            flash[:error] = "Couldnt save answer"
            redirect_to questions_path
        end
    else
        flash[:error] = "Not a valid answer => #{@user_answer.attributes.inspect}"
        redirect_to questions_path
    end
  end


end
