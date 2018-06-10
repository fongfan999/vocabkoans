class Bot::Base::Deliverer
  include Service

  attr_reader :user

  def initialize(user)
    @user = user
  end

  protected

  def deliver_with(payload)
    Facebook::Messenger::Bot.deliver(payload, access_token: ENV['FB_ACCESS_TOKEN'])
  rescue Facebook::Messenger::FacebookError => e
    SentryJob.perform_later(e)
  end

  private

  def recipient
    { id: user.messenger_uid }
  end
end
