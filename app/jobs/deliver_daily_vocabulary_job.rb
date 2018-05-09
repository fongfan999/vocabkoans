class DeliverDailyVocabularyJob < ApplicationJob
  def perform(user)
    vocabulary = next_vocabulary_for(user)
    Bot::Vocabulary::Deliverer.perform(user, vocabulary)
  end

  private

  def next_vocabulary_for(user)
    return if user.subscriptions.created_in_today.not_sending.not_reading.empty?

    subscription = user.subscriptions.created_in_today.not_sending.ascending.first
    return Vocabulary.find(subscription.vocabulary_id) if subscription

    subscription = user.subscriptions.created_in_today.not_reading.ascending.first
    Vocabulary.find(subscription.vocabulary_id)
  end
end
