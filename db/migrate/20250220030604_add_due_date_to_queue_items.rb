class AddDueDateToQueueItems < ActiveRecord::Migration[8.0]
  def change
    add_column :queue_items, :due_date, :date
  end
end
