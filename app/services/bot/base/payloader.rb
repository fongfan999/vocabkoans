class Bot::Base::Payloader
  include Service

  attr_reader :bot, :sender_id

  def initialize(bot)
    @bot = bot
    @sender_id = bot.sender['id']
  end

  def user
    @user ||= User.find_or_initialize_by(messenger_uid: sender_id)
  end
end
