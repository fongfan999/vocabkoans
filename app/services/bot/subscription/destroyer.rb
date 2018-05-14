class Bot::Subscription::Destroyer < Bot::Subscription::Application
  def perform
    user.persisted? && user.update_columns(words_of_the_day: 0)
  end
end
