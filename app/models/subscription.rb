class Subscription < ApplicationRecord
  include Ordering

  belongs_to :user
  belongs_to :vocabulary

  scope :created_in_today, -> { where('created_at::date = ?', Date.current) }
  scope :not_sending, -> { where(sent_at: nil) }
  scope :not_reading, -> { where(read_at: nil) }
end
