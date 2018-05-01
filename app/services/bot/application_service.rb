class Bot::ApplicationService
  attr_reader :sender_id

  def initialize(bot)
    @sender_id = bot.sender['id']
  end

  def user
    @user ||= User.find_or_initialize_by(messenger_uid: sender_id)
  end
end
