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

    it 'is valid with a status' do
        queue_item = build(:queue_item, status: 'Test Status')
        expect(queue_item).to be_valid
    end
  
end