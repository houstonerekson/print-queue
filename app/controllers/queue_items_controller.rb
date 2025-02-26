class QueueItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_queue_item, only: %i[show edit update destroy]

  def index
    @queue_items = current_user.queue_items.all.order(:status, :due_date)
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
      redirect_to queue_items_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @queue_item = QueueItem.find(params[:id])
  
    if @queue_item.update(queue_item_params)
      flash[:notice] = "Queue item updated successfully!"
      redirect_to queue_items_path
    else
      flash.now[:alert] = "Failed to update queue item. Please fix any errors and try again."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @queue_item.destroy
    flash[:notice] = "Queue item deleted successfully!"
    redirect_to queue_items_path
  end

  private

  def set_queue_item
    @queue_item = QueueItem.find(params[:id])
  end

  def queue_item_params
    params.require(:queue_item).permit(:reference_id, :name, :status, :due_date, :notes, variations: [:key, :value])
  end
end