class Payloader::MarkVocabularyAsRead < Payloader::Application
  def reply!
    subscription.touch(:read_at)
    # TODO: Randomize the response
    bot.reply(text: "You're welcome")
  end

  private

  def subscription
    id = bot.messaging.dig('message', 'quick_reply', 'payload')[/\d+/]
    Subscription.find(id)
  end
end
