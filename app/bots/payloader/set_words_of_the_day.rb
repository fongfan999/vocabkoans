class Payloader::SetWordsOfTheDay < Payloader::Application
  GOALS = [1, [3, true], 5].freeze

  def reply!
    bot.reply(text: i18n_t(:set_words_of_the_day), quick_replies: quick_replies)
  end

  private

  def quick_replies
    text_quick_replies(title_and_payloads)
  end

  def title_and_payloads
    goals_title_and_payloads.push([I18n.t('cancel'), 'CANCEL_SUBSCRIPTION'])
  end

  def goals_title_and_payloads
    payload = 'COMPLETE_SUBSCRIPTION'

    GOALS.map do |count, recommended|
      title = I18n.t('word', count: count)
      title += ' 👍' if recommended

      [title, payload]
    end
  end
end
