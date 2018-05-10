class DeliverDailyVocabularyJob < ApplicationJob
  def perform(user)
    return false if user.last_read_vocabulary_at.nil?

    vocabulary = next_vocabulary_for(user)
    Bot::Vocabulary::Deliverer.perform(user, vocabulary)
  end

  private

  def next_vocabulary_for(user)
    subscription = user_subscriptions_in_today(user).not_sending.first
    return subscription.vocabulary if subscription

    false
  end

  def user_subscriptions_in_today(user)
    @user_subscriptions ||= user.subscriptions.created_in_today.ascending
  end
end
