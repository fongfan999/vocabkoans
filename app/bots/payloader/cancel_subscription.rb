class Payloader::CancelSubscription < Payloader::Application
  def reply!
    Bot::Subscription::Destroyer.perform(bot)
    i18n_t(:cancel_subscription).each { |sentence| bot.reply(text: sentence) }
  end
end
