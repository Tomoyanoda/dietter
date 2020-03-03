class ToppagesController < ApplicationController
  def index
    if user_signed_in?
      @post = current_user.posts.build
      @posts = current_user.posts.order(id: :desc).page(params[:page])
    end
  end
end
