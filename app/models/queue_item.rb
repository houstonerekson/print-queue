class QueueItem < ApplicationRecord  
  validates :name, presence: true, length: { maximum: 100 }
  validates :due_date, presence: true
  validates :notes, length: { maximum: 1000 }, allow_blank: true
  
  validate :variations_are_valid

  belongs_to :user

  enum :status, { pending: 0, printing: 1, complete: 2 }

  # Variations stored as a JSONB array of objects
  attribute :variations, :jsonb, default: []

  private

  def variations_are_valid
    if variations.present? && variations.any? { |variation| variation['title'].blank? || variation['value'].blank? }
      errors.add(:variations, "Each variation must have a title and a value")
    end
  end
end