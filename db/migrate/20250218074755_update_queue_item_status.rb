class UpdateQueueItemStatus < ActiveRecord::Migration[8.0]
  def change
    # Change the column type from string to integer
    change_column :queue_items, :status, :integer, default: 0, null: false
  end
end
