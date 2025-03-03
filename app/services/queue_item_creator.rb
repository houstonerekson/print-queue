class QueueItemCreator
    def initialize(user, params)
      @user = user
      @params = params
    end
  
    def call
      queue_item = @user.queue_items.new(@params)
      
      # Add any logic to manage additional parameters (e.g., setting status, defaults)
      queue_item.save!
      queue_item
    end
  end