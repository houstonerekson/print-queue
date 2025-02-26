class QueueItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_queue_item, only: %i[show edit update destroy]

  def index
    # Get the status filter from the query parameters
    status_filter = params[:status]

    # If a status filter is provided, filter the queue items by status
    if status_filter.present?
      @queue_items = QueueItem.where(status: status_filter).order(:due_date)
    else
      # Otherwise, fetch all the queue items
      @queue_items = QueueItem.where.not(status: "complete").order(:status, :due_date)
    end
  end

  def show
  end

  def new
    @queue_item = QueueItem.new
  end

  def create
    @queue_item = current_user.queue_items.new(queue_item_params)
    if @queue_item.save
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
      redirect_to root_path
    else
      flash.now[:alert] = "Failed to update queue item. Please fix any errors and try again."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @queue_item.destroy
    flash[:notice] = "Queue item deleted successfully!"
    redirect_to root_path
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