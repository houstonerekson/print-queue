class EtsyOrderProcessor
  def self.process(json_data, user)
    json_data.each do |order|
      order_id = order["receipt_id"]
      created_at = Time.at(order["created_timestamp"].to_i)
      updated_at = Time.at(order["updated_timestamp"].to_i)

      order["transactions"].each do |transaction|
        # Skip digital products
        next if transaction["is_digital"]

        order_item_id = transaction["transaction_id"]
        reference_info = "Etsy Order: #{order_id}"
        name = transaction["title"]
        quantity = transaction["quantity"]
        expected_ship_date = transaction["expected_ship_date"] ? Time.at(transaction["expected_ship_date"].to_i) : nil
        variations = transaction["variations"].map { |v| { v["formatted_name"] => v["formatted_value"] } }

        queue_item = QueueItem.find_or_initialize_by(order_item_id: order_item_id)

        queue_item.assign_attributes(
          order_id: order_id,
          reference_id: reference_info,
          name: name,
          quantity: quantity,
          variations: variations,
          due_date: expected_ship_date,
          created_at: created_at,
          updated_at: updated_at,
          user: user
        )

        if queue_item.changed?
          queue_item.save!
          puts "Updated QueueItem: #{queue_item.id}"
        else
          puts "No changes for QueueItem: #{queue_item.id}"
        end
      end
    end
    puts "Processing complete."
  end
end