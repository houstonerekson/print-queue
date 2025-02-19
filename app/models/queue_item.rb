class QueueItem < ApplicationRecord  
    validates :name, presence: true, length: { maximum: 100 }
    validates :color, presence: true, length: { maximum: 50 }
    enum :status, { pending: 0, printing: 1, completed: 2, failed: 3 }
end