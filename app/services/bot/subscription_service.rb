class Bot::SubscriptionService < Bot::ApplicationService
  def save
    user.words_of_the_day = bot.text[/\d/]
    user.save
  end

  def destroy
    user.persisted? && user.update_columns(words_of_the_day: 0)
  end
end
