class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Message posted.'
      redirect_to root_url
    else
      @microposts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'Posting message failed.'
      render 'toppages/index'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Message deleted.'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content,:weight,:image)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
