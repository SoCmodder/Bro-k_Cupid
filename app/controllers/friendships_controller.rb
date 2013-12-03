class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:success] = "Bro Added, Yo."
      redirect_to current_user
    else
      flash[:error] = "Sorry Bro, we couldn't add your bud at this time. Try again later."
      #redirect_to root_url
    end
  end

  def destroy
    if params[:nested][:inverse] == "false"
        @friendship = current_user.friendships.find(params[:nested][:friendship])
        @friendship.destroy
        flash[:notice] = "Removed friendship"
        redirect_to current_user
    else
        flash[:notice] = "Removed friendship"
        @u_id = (params[:nested][:friend_id]).to_i
        @f_id = (params[:id]).to_i
        @friendship = Friendship.where( :user_id=>@u_id, :friend_id=>@f_id).first
        
        #flash[:notice] = "Params: #{params} id: #{@u_id}    f_id: #{@f_id}"
        @friendship.destroy
        redirect_to current_user
    end

  end


end
