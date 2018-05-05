class Payloader::CompleteSubscription < Payloader::Application
  def reply!
    Bot::SubscriptionCreator.perform(bot)
    bot.reply(text: i18n_t('complete_subscription'))
  end
end
