class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:profile,:image,:image_cache])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name,:profile,:image,:image_cache,:remove_image])
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    flash.now[:error] = I18n.t("errors.messages.access_denied")
    redirect_to main_app.root_path
  end
  
  def counts(user)
    @count_posts = user.posts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_likes = user.liked_posts.count
  end
  
end
