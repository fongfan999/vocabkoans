module I18nScopable
  extend ActiveSupport::Concern

  def i18n_t(key, args = {})
    I18n.t(key, scope: i18n_scope, **args)
  end

  private

  def i18n_scope
    raise NotImplementedError
  end
end
