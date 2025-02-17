class QueueItem < ApplicationRecord
    validates :name, presence: true
end
