class User < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :vocabularies, through: :subscriptions
end
