class Payloader::CompleteSubscription < Payloader::Application
  def perform
    Bot::Subscription::Creator.perform(bot)
    bot.reply(text: i18n_t('complete_subscription'))
  end
end
