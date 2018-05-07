class Payloader::Application
  include QuickRepliesGenerator
  include I18nScopable

  attr_reader :bot

  def initialize(bot)
    @bot = bot
  end

  def reply!
    raise NotImplementedError
  end

  private

  def i18n_scope
    'bots'
  end
end
