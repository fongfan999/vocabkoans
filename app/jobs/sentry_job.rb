class SentryJob < ApplicationJob
  queue_as :very_high

  def perform(event)
    Raven.send_event(event)
  end
end
