class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  def index
    @bros = User.without_user(current_user).all
    @scores = Hash.new
    @weights = Hash.new
    @weights[1] = 0
    @weights[2] = 1
    @weights[3] = 10
    @weights[4] = 50
    @weights[5] = 100


    @user = current_user
    for bro in @bros do
        diff = 0
        comparedTotal1 = 0
        comparedTotal2 = 0
        total1 = 0
        total2 = 0
        for user_ans in @user.user_answers do
            for bros_ans in bro.user_answers do
                if user_ans.question_id == bros_ans.question_id
                    diff = 5 - (user_ans.answer.to_i - bros_ans.answer.to_i).abs
                    comparedTotal1 += diff * @weights[user_ans.importance.to_i]
                    comparedTotal2 += diff * @weights[bros_ans.importance.to_i]
                    total1 += 5 * @weights[user_ans.importance.to_i]
                    total2 += 5 * @weights[bros_ans.importance.to_i]
                end
            end
        end
        if total1 == 0 or total2 == 0
          @scores[bro.id] = 0
        else
          @scores[bro.id] = ( Math.sqrt( (comparedTotal1.to_f/total1.to_f) * (comparedTotal2.to_f/total2.to_f) ) * 100 )
        end
    end


    @users = User.without_user(current_user).paginate(:order =>"name ASC", :page=> params[:page])

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Bro-k Cupid"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    #@user = User.where(:id => params[:id]).first
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  #def signed_in_user
  #    unless signed_in?
  #        store_location
  #        redirect_to signin_url, notice: "Please sign in."
  #    end
  #end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
