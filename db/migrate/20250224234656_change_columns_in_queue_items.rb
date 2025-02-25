class ChangeColumnsInQueueItems < ActiveRecord::Migration[8.0]
  def change
    change_column_null :queue_items, :color, true
  end
end
