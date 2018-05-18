Raven.configure do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.async = ->(event) { SentryJob.perform_later(event.to_hash) }
  config.logger = Raven::Logger.new(STDOUT)
end
