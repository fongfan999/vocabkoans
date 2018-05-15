class Bot::Vocabulary::Summarizer < Bot::Vocabulary::Application
  def perform
    deliver_for_today && deliver_for_all_time
  end

  private

  def deliver_for_today
    indexs = user.subscriptions.in_today.pluck(:vocabulary_sense_index)
    status = indexs.all? { |index| index > 0 } ? 'good' : 'bad'

    Facebook::Messenger::Bot.deliver(default_payload.merge(
      message: { text: i18n_t("today.#{status}") }
    ), access_token: ENV['ACCESS_TOKEN'])
  end

  def deliver_for_all_time
    count = user.subscriptions.sent.count
    date  = user.created_at.to_date.to_s(:long_ordinal)

    Facebook::Messenger::Bot.deliver(default_payload.merge(
      message: { text: i18n_t('all_time', count: count, date: date) }
    ), access_token: ENV['ACCESS_TOKEN'])
  end

  def i18n_scope
    'bots.vocabularies.summary'
  end
end
