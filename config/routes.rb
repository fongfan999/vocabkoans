require 'sidekiq/web'

Rails.application.routes.draw do
  mount Facebook::Messenger::Server, at: 'messenger_webhook'
  mount Sidekiq::Web,                at: 'sidekiq'
end
