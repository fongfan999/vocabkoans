class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :vocabulary

  scope :created_in_today, -> { where('created_at::date = ?', Date.current) }
end
