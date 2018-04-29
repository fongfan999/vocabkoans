class ApplicationBot
  AVAILABLE_EVENTS = %i(message postback).freeze

  include Facebook::Messenger
  extend MessengerEventExtractor

  attr_reader :message

  # Any class inherit from this class and their undercored, symbolized class name
  # in the available events will process incoming messages from the Facebook Messenger Platform
  # The class might define `:perform` method to respond Messenger users
  # The following example will process `:postback` event:
  #
  # class PostbackBot < ApplicationBot
  #  def perform(message)
  #    # do something
  #  end
  # end
  def self.inherited(klass)
    event = messenger_eventify(klass)
    return super if AVAILABLE_EVENTS.exclude?(event)

    Bot.on(event) { |message| klass.new(message).perform }
  end

  def initialize(message)
    @message = message
  end

  def perform
    Rails.logger.warn("`:#{__method__}` is an abstract method. Should we define it?")
  end
end
