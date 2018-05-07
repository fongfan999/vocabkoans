module Randomizer
  extend ActiveSupport::Concern

  included do
    # OPTIMIZE This approach might be slow but it's okay now
    scope :random_ordering, -> { order(Arel.sql('RANDOM()')) }
    scope :random, ->(limit = nil) { random_ordering.first(limit) }
  end
end
