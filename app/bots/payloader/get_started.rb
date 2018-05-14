class Payloader::GetStarted < Payloader::Application
  def perform
    sentences = i18n_t(:get_started).dup
    call_to_action = sentences.pop

    sentences.each { |sentence| bot.reply(text: sentence) }
    bot.reply(text: call_to_action, quick_replies: quick_replies)
  end

  private

  def quick_replies
    text_quick_replies(
      I18n.t('yes') => 'SET_WORDS_OF_THE_DAY',
      I18n.t('no') => 'CANCEL_SUBSCRIPTION'
    )
  end
end
