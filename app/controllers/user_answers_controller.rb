class UserAnswersController < ApplicationController
    #rescue_from ActiveRecord::RecordNotUnique, with: :find_and_replace_answer
  def create
    if UserAnswer.exists?(:user_id=>params[:u_id], :question_id=>params[:q_id])
        @user_answer = UserAnswer.where(:user_id => params[:u_id], :question_id => params[:q_id])[0]
        @user_answer[:answer_id] = params[:ans]
        @user_answer[:importance] = params[:imp]
    else
        @user = User.find(params[:u_id])
        @user_answer = @user.user_answers.build(:user_id => params[:u_id], :question_id => params[:q_id], :answer_id => params[:ans], :importance => params[:imp])
    end

    if @user_answer.valid?
        if @user_answer.save
            flash[:notice] = "Thanks bro, got your answer"
            redirect_to questions_path
        else
            flash[:error] = "Couldnt save answer"
        end
    else
        render :action => 'new'
    end
  end

  #protected
  #  def find_and_replace_answer
  #  end

end
