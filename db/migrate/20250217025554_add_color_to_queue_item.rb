class AddColorToQueueItem < ActiveRecord::Migration[8.0]
  def change
    add_column :queue_items, :color, :string
  end
end
