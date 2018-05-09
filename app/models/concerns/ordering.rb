module Ordering
  extend ActiveSupport::Concern

  included do
    scope :ascending, -> (column = :id) { order(column => :asc) }
    scope :descending, -> (column = :id) { order(column => :desc) }
  end
end
