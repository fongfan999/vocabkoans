class ApplicationBot
  AVAILABLE_EVENTS = %i(message postback).freeze
  TAG = 'NON_PROMOTIONAL_SUBSCRIPTION'.freeze

  include MessengerEventExtractor

  attr_reader :bot

  # Any class inherit from this class and their undercored, symbolized class name
  # in the available events will process incoming messages, postbacks, deliveries, ...
  # from the Facebook Messenger Platform

  # The class might define `:perform` method to respond to Messenger users
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

    Facebook::Messenger::Bot.on(event) { |bot| klass.new(bot).perform }
  end

  def initialize(bot)
    @bot = bot
  end

  def perform
    Rails.logger.warn("`:#{__method__}` is an abstract method. Should we define it?")
  end

  private

  def payloader
    @payloader ||= begin
      classified_payloader = bot.payload.downcase.classify.sub(/\d+/, '')
      "Payloader::#{classified_payloader}".constantize.new(bot)
    end
  end
end
