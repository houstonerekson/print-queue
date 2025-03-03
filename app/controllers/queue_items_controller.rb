class QueueItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_queue_item, only: %i[show edit update destroy]

  def index
    @queue_items = current_user.queue_items
  
    # Default filter: Exclude completed items
    @queue_items = @queue_items.where.not(status: "complete") unless params[:status].present?
  
    # Apply filtering if a status is provided
    @queue_items = @queue_items.where(status: params[:status]) if params[:status].present?
  
    # Default sorting: By status (asc), then due_date (asc)
    default_order = { status: :asc, due_date: :asc }
  
    # Apply sorting based on params
    @queue_items = case params[:sort]
                   when "updated"
                     @queue_items.order(updated_at: :desc)
                   when "due_date"
                     @queue_items.order(due_date: :asc)
                   when "status"
                     @queue_items.order(status: :asc, due_date: :asc)
                   else
                     @queue_items.order(default_order)
                   end
  end

  def show
  end

  def new
    @queue_item = QueueItem.new
  end

  def create
    queue_item_creator = QueueItemCreator.new(current_user, queue_item_params)
    @queue_item = queue_item_creator.call

    if @queue_item.persisted?
      flash[:notice] = "Queue item created successfully!"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update 
    if @queue_item.update(queue_item_params)
      flash[:notice] = "Queue item updated successfully!"
      redirect_to root_path(status: params[:status], sort: params[:sort])
    else
      flash.now[:alert] = "Failed to update queue item. Please fix any errors and try again."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @queue_item.destroy
    flash[:notice] = "Queue item deleted successfully!"
    redirect_to root_path(status: params[:status], sort: params[:sort])
  end

  private

  def set_queue_item
    @queue_item = QueueItem.find(params[:id])
  end

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
end