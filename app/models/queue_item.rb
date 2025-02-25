class QueueItem < ApplicationRecord  
    after_initialize :set_default_variations, unless: :persisted?

    validates :name, presence: true, length: { maximum: 100 }
    validates :due_date, presence: true
    validates :notes, length: { maximum: 1000 }, allow_blank: true

    belongs_to :user

    enum :status, { pending: 0, printing: 1, complete: 2 }

    private

    def set_default_variations
        self.variations ||= []
    end

end