class DeliverDailyVocabularyJob < ApplicationJob
  def perform(user)
    vocabulary = next_vocabulary_for(user)
    Bot::Vocabulary::Deliverer.perform(user, vocabulary)
  end

  private

  def next_vocabulary_for(user)
    subscription = user_subscriptions_in_today(user).not_sending.first
    return subscription.vocabulary if subscription

    subscription = user_subscriptions_in_today(user).not_reading.first
    return subscription.vocabulary if subscription

    return false
  end

  def user_subscriptions_in_today(user)
    @user_subscriptions ||= user.subscriptions.created_in_today.ascending
  end
end
