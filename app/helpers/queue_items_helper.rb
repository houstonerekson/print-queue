module QueueItemsHelper
    def days_remaining(queue_item)
      return [nil, "No Due Date"] unless queue_item.due_date.present?
      
            days = (queue_item.due_date - Date.today).to_i
            text = if days.negative?
                "Late By"
            else
                "Due In"
            end
  
        [days, text]
    end
end