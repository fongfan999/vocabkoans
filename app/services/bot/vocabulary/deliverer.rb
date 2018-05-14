class Bot::Vocabulary::Deliverer < Bot::Vocabulary::Application
  include QuickRepliesGenerator

  def perform
    return unless vocabulary

    deliver_do_you_know unless sense_index.zero?
    Facebook::Messenger::Bot.deliver(payload, access_token: ENV['ACCESS_TOKEN'])

    subscription.touch(:sent_at) && user.update(last_read_vocabulary_at: nil)
  end

  private

  def deliver_do_you_know
    Facebook::Messenger::Bot.deliver(default_payload.merge(
      message: { text: i18n_t('do_you_know', word: vocabulary.word) }
    ), access_token: ENV['ACCESS_TOKEN'])
  end

  def subscription
    @subscription ||= user.subscriptions.find_by(vocabulary_id: vocabulary.id)
  end

  def sense_index
    subscription.vocabulary_sense_index
  end

  def payload
    default_payload.merge(message: { text: text, quick_replies: quick_replies })
  end

  def text
    sense = vocabulary.sense[sense_index]
    definition = sense['definition']
    examples = sense['examples'].map { |ex| "- #{ex}" }.join("\n")

    i18n_t('combo', word: vocabulary.word, word_class: vocabulary.word_class,
                    definition: definition, examples: examples)
  end

  def quick_replies
    text_quick_replies(i18n_t('got_it') => 'MARK_VOCABULARY_AS_READ')
  end
end
