class Payloader::MarkVocabularyAsRead < Payloader::Application
  def reply!
    user = User.find_by(messenger_uid: bot.sender['id'])
    user.touch(:last_read_vocabulary_at)

    bot.typing_off
    # TODO: Randomize the response
    # bot.reply(text: "You're welcome")
  end
end
