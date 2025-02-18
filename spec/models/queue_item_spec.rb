require 'rails_helper'

RSpec.describe QueueItem, type: :model do
    it 'is valid with a name' do
        queue_item = build(:queue_item, name: 'Test Item')
        expect(queue_item).to be_valid
    end

    it 'is invalid without a name' do
        queue_item = build(:queue_item, name: nil)
        expect(queue_item).to_not be_valid
    end

    describe "status enum" do
        it "has the correct statuses" do
          expect(QueueItem.statuses.keys).to contain_exactly("pending", "printing", "completed", "failed")
        end
    
        it "allows setting and querying statuses" do
            queue_item = create(:queue_item, status: :pending)
      
            expect(queue_item).to be_pending
            queue_item.printing!
            expect(queue_item).to be_printing
            queue_item.completed!
            expect(queue_item).to be_completed
            queue_item.failed!
            expect(queue_item).to be_failed
          end
    end
end