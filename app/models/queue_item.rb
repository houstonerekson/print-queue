class QueueItem < ApplicationRecord  
    validates :name, presence: true, length: { maximum: 100 }
    validates :color, presence: true, length: { maximum: 50 }
    validates :due_date, presence: true
    validates :notes, length: { maximum: 1000 }, allow_blank: true

    belongs_to :user

    enum :status, { pending: 0, printing: 1, complete: 2 }

end