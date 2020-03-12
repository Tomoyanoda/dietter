class UsersController < ApplicationController
    before_action :authenticate_user!
    
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
    
end
