class CreateQueueItems < ActiveRecord::Migration[8.0]
  def change
    create_table :queue_items do |t|
      t.string :name
      t.string :reference_id
      t.string :status
      t.string :priority
      t.timestamps
    end
  end
end