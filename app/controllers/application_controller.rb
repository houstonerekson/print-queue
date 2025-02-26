class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Make all users login or sign up before accessing any page.
  before_action :authenticate_user!, except: [:new, :create]
  def after_sign_in_path_for(resource)
    root_path
  end

  def index
    @status_filter = params[:status]  # Capture the 'status' query parameter
    @queue_items = QueueItem.all

    if @status_filter.present?
      @queue_items = @queue_items.where(status: @status_filter)
    end
  end
  
end
