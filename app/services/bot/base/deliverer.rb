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

  def recipient
    { id: user.messenger_uid }
  end
end
