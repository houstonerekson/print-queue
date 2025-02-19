FactoryBot.define do
    factory :queue_item do
      name { "Test Item" }
      color { "Test" }
      status { :pending }
    end
  end