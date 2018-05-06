class Bot::SubscriptionDestroyer < Bot::Base::Payloader
  def perform
    user.persisted? && user.update_columns(words_of_the_day: 0)
  end
end
