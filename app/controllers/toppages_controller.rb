class ToppagesController < ApplicationController
  def index
    if user_signed_in?
      @post = current_user.posts.build
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page]).per(5)
    end
  end
end
