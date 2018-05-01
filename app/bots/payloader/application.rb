class Payloader::Application
  include QuickRepliesGenerator

  attr_reader :bot

  def initialize(bot)
    @bot = bot
  end

  def reply!
    raise NotImplementedError
  end

  protected

  def i18n_t(key, args = {})
    I18n.t(key, scope: i18n_scope, **args)
  end

  private

  def i18n_scope
    'bots'
  end
end
