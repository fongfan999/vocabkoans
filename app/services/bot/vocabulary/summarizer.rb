class Bot::Vocabulary::Summarizer < Bot::Vocabulary::Application
  def perform
    deliver_for_today && deliver_for_all_time
  end

  private

  def deliver_for_today
    status = user.subscriptions.in_today.exists?(sent_at: nil) ? 'bad' : 'good'
    payload = default_payload.merge(message: { text: i18n_t("today.#{status}") })

    deliver_with(payload)
  end

  def deliver_for_all_time
    count   = user.subscriptions.sent.count
    date    = user.created_at.to_date.to_s(:long_ordinal)
    payload = default_payload.merge(message: {
      text: i18n_t('all_time', count: count, date: date)
    })

    deliver_with(payload)
  end

  def i18n_scope
    'bots.vocabularies.summary'
  end
end
