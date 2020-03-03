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
end
