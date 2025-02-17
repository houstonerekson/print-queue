class QueueItemsController < ApplicationController
    def index
      @queue_items = QueueItem.all
    end
end
