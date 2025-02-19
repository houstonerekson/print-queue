require 'rails_helper'

RSpec.describe "Edit Queue Items:", type: :request do
  let!(:queue_item) { create(:queue_item, name: "Old Name") }

  describe "GET /edit" do
    it "renders the edit form" do
      get edit_queue_item_path(queue_item)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Edit Queue Item")
    end
  end

  describe "PATCH /update" do
    it "updates the queue item" do
      patch queue_item_path(queue_item), params: { queue_item: { name: "Updated Name" } }
  
      queue_item.reload # Ensure we get the updated data from the database
  
      expect(queue_item.name).to eq("Updated Name") # Confirm update worked
    end

    it "renders errors if the update fails" do
      patch queue_item_path(queue_item), params: { queue_item: { name: nil } } # Invalid update
    
      expect(response.body).to include("Name can't be blank")
      expect(queue_item.reload.name).to eq(queue_item.name)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

RSpec.describe "Delete Queue Items:", type: :request do
  let!(:queue_item) { create(:queue_item, name: 'Test Item', status: :pending) }

  describe "DELETE /queue_items/:id" do
    it "deletes the queue item" do
      expect {
        delete queue_item_path(queue_item)
      }.to change(QueueItem, :count).by(-1)
      
      expect(response).to redirect_to(queue_items_path)
      follow_redirect!
      expect(flash[:notice]).to eq("Queue item deleted successfully!")
    end
  end
end