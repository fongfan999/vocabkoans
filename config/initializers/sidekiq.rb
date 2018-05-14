redis_url = ENV['REDIS_PROVIDER'] ||'redis://localhost:6379'
redis_db  = ENV['REDIS_DB'].to_i || 0

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, db: redis_db }
end

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, db: redis_db, network_timeout: 5 }
end
