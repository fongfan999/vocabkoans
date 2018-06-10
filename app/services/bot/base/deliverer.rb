class Bot::Base::Deliverer
  include Service

  attr_reader :user

  def initialize(user)
    @user = user
  end

  protected

  def deliver_with(payload)
    Facebook::Messenger::Bot.deliver(payload, access_token: ENV['FB_ACCESS_TOKEN'])
  rescue Facebook::Messenger::FacebookError => exception
    Raven.capture_exception(exception)
  end

  private

  def recipient
    { id: user.messenger_uid }
  end
end
