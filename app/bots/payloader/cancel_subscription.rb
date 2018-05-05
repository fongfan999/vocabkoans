class Payloader::CancelSubscription < Payloader::Application
  def reply!
    Bot::SubscriptionDestroyer.perform(bot)
    i18n_t(:cancel_subscription).each { |sentence| bot.reply(text: sentence) }
  end
end
