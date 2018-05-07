class Bot::Vocabulary::Informer < Bot::Vocabulary::Application
  attr_reader :daily_vocabulary

  def perform
    @daily_vocabulary = DailyVocabulary.new(user)
    @daily_vocabulary.save and deliver_message
  end

  private

  def deliver_message
    Facebook::Messenger::Bot.deliver(payload, access_token: ENV['ACCESS_TOKEN'])
  end

  def payload
    { tag: ApplicationBot::TAG, recipient: recipient, message: { text: text } }
  end

  def text
    i18n_t('informer', vocabularies: daily_vocabulary.formatted)
  end
end
