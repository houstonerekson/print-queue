FactoryBot.define do
    factory :queue_item do
      name { "Test Item" }
      color { "Test" }
      due_date {'01-01-2020'}
      status { :pending }
    end
  end