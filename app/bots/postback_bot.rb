class PostbackBot < ApplicationBot
  def perform
    bot.typing_on
    payloader.reply!
  end
end
