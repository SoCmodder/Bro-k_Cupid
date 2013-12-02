class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  def index
    #@bro_score = Rice::Bro.new()
    @bros = User.without_user(current_user).all

    # Format this users answers correctly for matching algo
    #  String of the form "Q_ID ANS IMP Q_ID ANS IMP ... "
    @user = current_user
    @user_vector = ""
    for ans in @user.user_answers do
        @user_vector = @user_vector+" "+ans.question_id.to_s()+" "+ans.answer.to_s()+" "+ans.importance.to_s()
    end

    @scores = Hash.new
    for bro in @bros do
        @bros_vector = ""
        for ans in bro.user_answers do
            @bros_vector = @bros_vector+" "+ans.question_id.to_s()+" "+ans.answer.to_s()+" "+ans.importance.to_s()
        end
        #@scores[bro.id] = @bro_score.Brofficiency(@user_vector, @bros_vector)

        @scores[bro.id] = 5
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
