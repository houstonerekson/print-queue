class QueueItemsController < ApplicationController
    def index
      @queue_items = QueueItem.all
    end

    def new
      @queue_item = QueueItem.new
    end

    def create
      @queue_item = QueueItem.new(queue_item_params)

      if @queue_item.save
        redirect_to queue_items_path, notice: "Queue item created successfully!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def queue_item_params
      params.require(:queue_item).permit(:name, :status)
    end
end
