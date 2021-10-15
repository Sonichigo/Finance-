class FriendshipsController < ApplicationController
  def create
    @friend = User.find(params[:friend])
    Friendship.create(user_id: current_user.id, friend_id: @friend.id)
    flash[:notice] = "#{@friend.email} was successfully added to your friends."
    redirect_to my_friends_path
  end

  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.where(user_id: current_user.id, friend_id: friend.id).first
    friendship.destroy
    flash[:notice] = "#{friend.first_name} was successfully removed from your friends."
    redirect_to my_friends_path
  end
end