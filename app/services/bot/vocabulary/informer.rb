class Bot::Vocabulary::Informer < Bot::Vocabulary::Application
  attr_reader :daily_vocabulary

  def perform
    @daily_vocabulary = DailyVocabularyCreator.perform(user)
    return unless @daily_vocabulary

    deliver_with(payload)
    user.touch(:last_read_vocabulary_at)
  end

  private

  def payload
    default_payload.merge(message: { text: text })
  end

  def text
    i18n_t('inform', vocabularies: daily_vocabulary.formatted)
  end
end
