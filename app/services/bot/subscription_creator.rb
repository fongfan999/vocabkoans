class Bot::SubscriptionCreator < Bot::ApplicationService
  def perform
    user.words_of_the_day = bot.text[/\d/]
    user.save
  end
end
