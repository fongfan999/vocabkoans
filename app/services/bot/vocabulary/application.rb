class Bot::Vocabulary::Application < Bot::Base::Deliverer
  include I18nScopable

  attr_reader :vocabulary

  def initialize(user, vocabulary = nil)
    @user, @vocabulary = user, vocabulary
  end

  protected

  def default_payload
    { tag: ApplicationBot::TAG, recipient: recipient }
  end

  private

  def i18n_scope
    'bots.vocabularies'
  end
end
