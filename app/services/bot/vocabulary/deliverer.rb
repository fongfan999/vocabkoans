class Bot::Vocabulary::Deliverer < Bot::Vocabulary::Application
  include QuickRepliesGenerator

  def perform
    return unless vocabulary

    Facebook::Messenger::Bot.deliver(payload, access_token: ENV['ACCESS_TOKEN'])
    user.subscriptions.find_by(vocabulary_id: vocabulary.id).touch(:sent_at)
    user.update_column(:last_read_vocabulary_at, nil)
  end

  private

  def payload
    {
      tag: ApplicationBot::TAG,
      recipient: recipient,
      message: { text: vocabulary.word, quick_replies: quick_replies }
    }
  end

  def quick_replies
    text_quick_replies(i18n_t('got_it') => 'MARK_VOCABULARY_AS_READ')
  end
end
