class Bot::Testing::Application < Bot::Base::Deliverer
  include I18nScopable

  attr_reader :vocabulary, :index

  def initialize(user, vocabulary, index = 0)
    @user       = user
    @vocabulary = vocabulary
    @index      = index
  end

  private

  def i18n_scope
    'bots.testing'
  end
end
