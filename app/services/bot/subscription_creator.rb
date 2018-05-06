class Bot::SubscriptionCreator < Bot::Base::Payloader
  def perform
    user.words_of_the_day = bot.text[/\d/]
    user.save
  end
end
