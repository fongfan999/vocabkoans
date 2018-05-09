class Bot::Vocabulary::Deliverer < Bot::Vocabulary::Application
  include QuickRepliesGenerator

  def perform
    return unless vocabulary

    subscription.touch(:sent_at)
    Facebook::Messenger::Bot.deliver(payload, access_token: ENV['ACCESS_TOKEN'])
  end

  private

  def subscription
    @subscription ||= user.subscriptions.find_by(vocabulary_id: vocabulary.id)
  end

  def payload
    {
      tag: ApplicationBot::TAG,
      recipient: recipient,
      message: { text: text, quick_replies: quick_replies }
    }
  end

  def text
    vocabulary.word
  end

  def quick_replies
    text_quick_replies(i18n_t('got_it') => "MARK_VOCABULARY_AS_READ#{subscription.id}")
  end
end
