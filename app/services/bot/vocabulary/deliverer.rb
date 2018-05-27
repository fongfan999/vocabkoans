class Bot::Vocabulary::Deliverer < Bot::Vocabulary::Application
  include QuickRepliesGenerator

  EX_LEN = 2.freeze

  def perform
    return unless vocabulary

    deliver_do_you_know unless sense_index.zero?
    deliver_with(payload(:text))
    deliver_with(payload(:audio)) if vocabulary.pronunciation_url.present?

    subscription.touch(:sent_at) && user.update(last_read_vocabulary_at: nil)
  end

  private

  def deliver_do_you_know
    payload = default_payload.merge(message: {
      text: i18n_t('do_you_know', word: vocabulary.word)
    })
    deliver_with(payload)
  end

  def subscription
    @subscription ||= user.subscriptions.find_by(vocabulary_id: vocabulary.id)
  end

  def sense_index
    subscription.vocabulary_sense_index
  end

  def payload(type = :text)
    message =
      case type
      when :text then { text: text }
      when :audio then { attachment: audio }
      end
    message = message.merge(quick_replies: quick_replies)
    default_payload.merge(message: message)
  end

  def audio
    {
      type: :audio,
      payload: {
        url: vocabulary.pronunciation_url,
        is_reusable: true
      }
    }
  end

  def text
    sense = vocabulary.sense[sense_index]
    definition = sense['definition']
    examples = sense['examples'].take(EX_LEN).map { |ex| "- #{ex}" }.join("\n")

    i18n_t('combo', word: vocabulary.word, word_class: vocabulary.word_class,
                    definition: definition, examples: examples,
                    ipa: vocabulary.ipa)
  end

  def quick_replies
    text_quick_replies(i18n_t('got_it') => 'MARK_VOCABULARY_AS_READ')
  end
end
