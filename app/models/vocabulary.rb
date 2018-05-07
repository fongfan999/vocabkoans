class Vocabulary < ApplicationRecord
  include Randomizer

  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  scope :without_sense, -> { select(:id, :word, :word_class) }
end
