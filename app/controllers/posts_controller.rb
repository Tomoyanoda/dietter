class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Message posted.'
      redirect_to root_url
    else
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page]).per(5)
      flash.now[:danger] = 'Posting message failed.'
      render 'toppages/index'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Message deleted.'
    redirect_back(fallback_location: root_path)
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def searchcontent
    @q = Post.ransack([:q])
    @posts = @q.result.order(id: :desc).page(params[:page]).per(5)
  end
  
  def searchweight
    @q = Post.ransack([:q])
    @posts = @q.result.order(weight: :desc).page(params[:page]).per(5)
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
