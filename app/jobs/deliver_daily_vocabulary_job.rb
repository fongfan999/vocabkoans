class DeliverDailyVocabularyJob < ApplicationJob
  def perform(user)
    return false if user.last_read_vocabulary_at.nil?

    vocabulary = next_vocabulary_for(user)
    Bot::Vocabulary::Deliverer.perform(user, vocabulary)
  end

  private

  MAX_DEFINITIONS = 2.freeze

  def next_subscription_by_vocabulary_sense_index
    user_subscriptions_in_today.ascending(:vocabulary_sense_index).find do |sub|
      next if sub.vocabulary_sense_index > MAX_DEFINITIONS

      sub.increment!(:vocabulary_sense_index)
      sub.vocabulary.sense.at(sub.vocabulary_sense_index)
    end
  end

  def next_vocabulary_for(user)
    subscription = user_subscriptions_in_today(user).not_sending.ascending.first
    return subscription.vocabulary if subscription

    next_subscription_by_vocabulary_sense_index&.vocabulary
  end

  def user_subscriptions_in_today(user = nil)
    @_user_subscriptions_in_today ||= user.subscriptions.created_in_today
  end
end
