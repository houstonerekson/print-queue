class MigrateColorToVariations < ActiveRecord::Migration[8.0]
  def up
    QueueItem.find_each do |queue_item|
      if queue_item.color.present?
        # Migrate the color data to variations
        color_variation = { "Color" => queue_item.color }

        # Add to the variations JSON field
        queue_item.update(variations: [color_variation])
      end
    end

    # Remove the color column after migration
    remove_column :queue_items, :color
  end

  def down
    # In case of rollback, we restore color to the original column
    add_column :queue_items, :color, :string

    QueueItem.find_each do |queue_item|
      if queue_item.variations.present?
        # Attempt to extract 'Color' variation if it exists
        color_variation = queue_item.variations.find { |v| v.key?("Color") }
        if color_variation
          queue_item.update(color: color_variation["Color"])
        end
      end
    end
  end
end
