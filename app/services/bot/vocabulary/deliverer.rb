class Bot::Vocabulary::Deliverer < Bot::Vocabulary::Application
  def perform
    return unless vocabulary

    user.subscriptions.find_by(vocabulary_id: vocabulary.id).touch(:sent_at)
    Facebook::Messenger::Bot.deliver(payload, access_token: ENV['ACCESS_TOKEN'])
  end

  private

  def payload
    { tag: ApplicationBot::TAG, recipient: recipient, message: { text: text } }
  end

  def text
    vocabulary.word
  end
end
