class Subscription < ApplicationRecord
  include Ordering

  belongs_to :user
  belongs_to :vocabulary

  scope :in_today, -> { where('created_at::date = ?', Date.current) }
  scope :not_sent, -> { where(sent_at: nil) }
  scope :sent, -> { where.not(sent_at: nil) }
end
