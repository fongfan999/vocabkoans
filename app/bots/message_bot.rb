class MessageBot < ApplicationBot
  def perform
    bot.typing_on
    return payloader.reply! if define_singleton_payload_on_bot

    # TODO: Notify administrators to reply this user
    bot.reply(text: %Q(You texted "#{bot.text}"))
  end

  private

  def define_singleton_payload_on_bot
    _payload = bot.messaging.dig('message', 'quick_reply', 'payload')
    return if _payload.blank?

    bot.define_singleton_method(:payload) { _payload }
  end
end
