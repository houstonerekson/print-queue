class QueueItem < ApplicationRecord  
  belongs_to :user

  enum :status, { pending: 0, printing: 1, complete: 2 }

  # Variations stored as a JSONB array of objects
  attribute :variations, :jsonb, default: []

  validates :name, presence: true, length: { maximum: 100 }
  validates :due_date, presence: true
  validates :notes, length: { maximum: 1000 }, allow_blank: true
  validate :variations_are_valid

  private

  def variations_are_valid
    return if variations.blank?

    unless variations.is_a?(Array)
      errors.add(:variations, "must be an array")
      return
    end

    variations.each do |variation|
      unless variation.is_a?(Hash) && variation['title'].present? && variation['value'].present?
        errors.add(:variations, "Each variation must have a title and a value")
      end
    end
  end
end
