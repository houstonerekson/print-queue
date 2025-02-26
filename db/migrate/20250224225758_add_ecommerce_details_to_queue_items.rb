class AddEcommerceDetailsToQueueItems < ActiveRecord::Migration[8.0]
  def change
    add_column :queue_items, :order_id, :bigint, null: true
    add_column :queue_items, :order_item_id, :bigint, null: true
    add_column :queue_items, :quantity, :integer, null: false, default: 1
    add_column :queue_items, :variations, :jsonb, null: true
  end
end