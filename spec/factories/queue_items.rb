FactoryBot.define do
    factory :queue_item do
      name { "Test Item" }
      status { :pending }
    end
  end