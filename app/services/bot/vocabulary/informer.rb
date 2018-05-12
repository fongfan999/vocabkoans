class Bot::Vocabulary::Informer < Bot::Vocabulary::Application
  attr_reader :daily_vocabulary

  def perform
    @daily_vocabulary = DailyVocabulary.new(user)
    @daily_vocabulary.save and deliver_message
  end

  private

  def deliver_message
    Facebook::Messenger::Bot.deliver(payload, access_token: ENV['ACCESS_TOKEN'])
    user.touch(:last_read_vocabulary_at)
  end

  def payload
    default_payload.merge(message: { text: text })
  end

  def text
    i18n_t('inform', vocabularies: daily_vocabulary.formatted)
  end
end
