class User < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :vocabularies, through: :subscriptions

  scope :not_created_in_today, -> { where.not('created_at::date = ?', Date.current) }
  scope :have_subscribed, -> { where(words_of_the_day: 1..Float::INFINITY) }
  scope :active, -> { not_created_in_today.have_subscribed }
end
