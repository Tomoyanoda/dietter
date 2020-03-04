class UsersController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @users = User.order(id: :desc).page(params[:page]).per(5)    
    end
    
    def show
        @user = User.find(params[:id])
        @posts = @user.posts.order(id: :desc).page(params[:page])
        counts(@user)
    end
    def followings
        @user = User.find(params[:id])
        @followings = @user.followings.page(params[:page])
        counts(@user)
    end
  
    def followers
        @user = User.find(params[:id])
        @followers = @user.followers.page(params[:page])
        counts(@user)
    end
end
