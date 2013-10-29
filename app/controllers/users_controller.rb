class UsersController < ApplicationController
    before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
    before_filter :correct_user,   only: [:edit, :update]

    def show
        @user = User.find(params[:id])
        @posts = @user.posts.paginate(page: params[:page])
    end

    def index
        @users = User.without_user(current_user).paginate(page: params[:page])
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
