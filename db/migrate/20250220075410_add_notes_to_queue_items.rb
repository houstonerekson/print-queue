class AddNotesToQueueItems < ActiveRecord::Migration[8.0]
  def change
    add_column :queue_items, :notes, :text
  end
end
