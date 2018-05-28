class MessengerProvider < Facebook::Messenger::Configuration::Providers::Base
  def valid_verify_token?(verify_token)
    verify_token == ENV['MESSENGER_VERIFY_TOKEN']
  end

  def app_secret_for(_)
    ENV['FB_APP_SECRET']
  end

  def access_token_for(recipient)
    ENV['FB_ACCESS_TOKEN']
  end
end

Facebook::Messenger.configure do |config|
  config.provider = MessengerProvider.new
end
