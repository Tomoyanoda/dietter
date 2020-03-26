class ToppagesController < ApplicationController
  def index
    if user_signed_in?
      @post = current_user.posts.build
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page]).per(5)
    end
  end
  def new_guest
    user = User.find_or_create_by!(email: 'xyz@gmail.com') do |user|
    user.password = SecureRandom.urlsafe_base64
  end
    sign_in user
    redirect_to root_path, notice: 'Guest user logged in.'
  end
end
