class ApplicationBot
  AVAILABLE_EVENTS = %i(message postback).freeze

  include Facebook::Messenger
  include MessengerEventExtractor
  include MessengerProfile

  attr_reader :bot

  # Any class inherit from this class and their undercored, symbolized class name
  # in the available events will process incoming messages, postbacks, deliveries, ...
  # from the Facebook Messenger Platform

  # The class might define `:perform` method to respond Messenger users
  # The following example will process `:postback` event:
  #
  # class PostbackBot < ApplicationBot
  #  def perform
  #    # bot.reply(text: 'Good morning!')
  #    # do something
  #  end
  # end
  def self.inherited(klass)
    event = messenger_eventify(klass)
    return super if AVAILABLE_EVENTS.exclude?(event)

    Bot.on(event) { |bot| klass.new(bot).perform }
  end

  def initialize(bot)
    @bot = bot
  end

  def perform
    Rails.logger.warn("`:#{__method__}` is an abstract method. Should we define it?")
  end
end
