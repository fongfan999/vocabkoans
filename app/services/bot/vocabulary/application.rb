class Bot::Vocabulary::Application < Bot::Base::Deliverer
  include I18nScopable

  private

  def i18n_scope
    'bots.vocabularies'
  end
end
