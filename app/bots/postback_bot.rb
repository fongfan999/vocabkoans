class PostbackBot < ApplicationBot
  def perform
    bot.typing_on
    payloader.perform
  end
end
