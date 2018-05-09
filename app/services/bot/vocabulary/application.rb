class Bot::Vocabulary::Application < Bot::Base::Deliverer
  include I18nScopable

  attr_reader :vocabulary

  def initialize(user, vocabulary = nil)
    @user, @vocabulary = user, vocabulary
  end

  private

  def i18n_scope
    'bots.vocabularies'
  end
end
