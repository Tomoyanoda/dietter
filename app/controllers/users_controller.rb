class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit]
  load_and_authorize_resource

  def index
    @users = User.order(id: :desc).page(params[:page]).per(5)
  end
  
  def show
    unless User.find_by(id: params[:id]).nil?
      @user = User.find_by(id: params[:id])
      @posts = @user.posts.order(id: :desc).page(params[:page]).per(5)
      counts(@user)
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  def edit
  end
  
  def destroy
    @user.destroy
    flash[:success] = 'User deleted.'
    redirect_back(fallback_location: root_path)
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.order(id: :desc).page(params[:page]).per(5)
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.order(id: :desc).page(params[:page]).per(5)
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.liked_posts.page(params[:page]).per(5)
    counts(@user)
  end

  def searchprofile
    @q = User.ransack(params[:q])
    @users = @q.result.order(id: :desc).page(params[:page]).per(5)
  end

  def graph
    @posts = Post.where(user_id: current_user.id).all.order('created_at ASC')
    @weights = @posts.map(&:weight)
    @dates = @posts.map{|post| post.created_at.strftime('%Y/%m/%d')}
    gon.json_weights = JSON.dump(@weights)
    gon.json_dates = JSON.dump(@dates)
    
  end
  
  private
  
  def ensure_correct_user
    @user = User.find(params[:id])
    if @user != current_user
      flash[:notice] = "You cannot access this page."
      redirect_back(fallback_location: user_path(current_user))
    elsif @user.email == 'xyz@gmail.com'
      redirect_to request.referer, notice: "Guest user cannot."
    else
      render :edit
    end
  end
end
