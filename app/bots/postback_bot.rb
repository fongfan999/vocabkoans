class PostbackBot < ApplicationBot
  def perform
    bot.reply(text: "#{bot.payload} :)")
  end
end
