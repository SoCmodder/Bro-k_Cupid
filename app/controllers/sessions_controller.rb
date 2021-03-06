class SessionsController < ApplicationController

  def new
    render 'new'
  end

  def create
    #user = User.find_by(email: params[:session][:email].downcase)
    user = User.where(email: params[:session][:email].downcase).first
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash[:error] = 'Woah, bro! Are you sure you got that email/password combination right?'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
