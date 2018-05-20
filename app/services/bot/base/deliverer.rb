class Bot::Base::Deliverer
  include Service

  attr_reader :user

  def initialize(user)
    @user = user
  end

  protected

  def deliver_with(payload)
    Facebook::Messenger::Bot.deliver(payload, access_token: ENV['ACCESS_TOKEN'])
  end

  private

  def default_payload
    { tag: ApplicationBot::TAG, recipient: recipient }
  end

  def recipient
    { id: user.messenger_uid }
  end
end
