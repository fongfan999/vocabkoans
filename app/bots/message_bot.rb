class MessageBot < ApplicationBot
  def perform
    message.typing_on
    message.reply(text: 'Hello World')
  end
end
