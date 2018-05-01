class Payloader::CompleteSubscription < Payloader::Application
  def reply!
    service = Bot::SubscriptionService.new(bot)
    service.save

    bot.reply(text: i18n_t('complete_subscription'))
  end
end
