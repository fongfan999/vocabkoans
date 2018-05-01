class Payloader::CancelSubscription < Payloader::Application
  def reply!
    service = Bot::SubscriptionService.new(bot)
    service.destroy

    i18n_t(:cancel_subscription).each { |sentence| bot.reply(text: sentence) }
  end
end
