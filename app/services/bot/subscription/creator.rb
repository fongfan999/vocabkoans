class Bot::Subscription::Creator < Bot::Subscription::Application
  def perform
    user.words_of_the_day = bot.text[/\d/]
    user.save
  end
end
