class Bot::SubscriptionService < Bot::ApplicationService
  def destroy
    user.persisted? && user.update_columns(words_of_the_day: 0)
  end
end
