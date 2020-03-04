class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = 'You have followed the user.'
    redirect_to user
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = 'The user has been unfollowed.'
    redirect_to user
  end
end
