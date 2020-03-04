class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    post = Post.find(params[:post_id])
    post.like(current_user)
    flash[:success] = 'Favorited post'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    post.unlike(current_user)
    flash[:success] = 'Post removed from favorites'
    redirect_back(fallback_location: root_path)
  end
end
