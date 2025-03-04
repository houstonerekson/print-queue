class Api::V1::QueueItemsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user!
  before_action :authenticate_with_api_key!

  rescue_from StandardError, with: :render_internal_server_error
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def create
    @queue_item = current_user.queue_items.new(queue_item_params)

    if @queue_item.save
      render json: { message: 'Queue item created successfully', queue_item: @queue_item }, status: :created
    else
      render json: { errors: @queue_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  
    def queue_item_params
        params.require(:queue_item).permit(
          :name, 
          :reference_id, 
          :status, 
          :priority, 
          :due_date, 
          :notes, 
          :user_id, 
          :order_id, 
          :order_item_id, 
          :quantity, 
          variations: [:title, :value]
        )
      end

      def authenticate_with_api_key!
        api_key = request.headers['Authorization']&.split(' ')&.last
        @current_user = User.joins(:api_keys).find_by(api_keys: { key: api_key })
    
        render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
      end
    
      def current_user
          @current_user
      end
      
      def render_unprocessable_entity(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
      end
    
      def render_not_found(exception)
        render json: { error: exception.message }, status: :not_found
      end
    
      def render_internal_server_error(exception)
        render json: { error: exception.message }, status: :internal_server_error
      end
  end