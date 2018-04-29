Rails.application.routes.draw do
  mount Facebook::Messenger::Server, at: 'messenger_webhook'
end
