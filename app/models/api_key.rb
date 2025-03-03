class ApiKey < ApplicationRecord
  belongs_to :user

  validates :key, presence: true, uniqueness: true
  validates :description, presence: true

  before_validation :generate_key, on: :create

  private

  def generate_key
    self.key ||= SecureRandom.hex(32) # Generates a random 64-character key
  end
end