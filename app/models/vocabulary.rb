class Vocabulary < ApplicationRecord
  include Randomizer

  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
end
