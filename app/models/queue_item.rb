class QueueItem < ApplicationRecord  
    validates :name, presence: true
    enum :status, { pending: 0, printing: 1, completed: 2, failed: 3 }
end
