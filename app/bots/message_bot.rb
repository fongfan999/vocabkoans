class MessageBot < ApplicationBot
  def perform
    bot.typing_on
    bot.reply(text: %Q(You texted "#{bot.text}"))
  end
end
