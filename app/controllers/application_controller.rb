class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Make all users login or sign up before accessing any page.
  before_action :authenticate_user!, except: [:new, :create]
  def after_sign_in_path_for(resource)
    root_path
  end
  
end
