module Payloader
  class BypassFacebookReviews < Application
    def perform
      lowercase_text = bot.text.downcase

      return GetStarted.perform(bot) if lowercase_text == 'get started'
      return SetWordsOfTheDay.perform(bot) if lowercase_text == 'yes'
      return CompleteSubscription.perform(bot) if lowercase_text =~ /\d words?/
      return CancelSubscription.perform(bot) if %w(cancel no).include?(lowercase_text)

      bot.reply(text: "Sorry :(, I don't understand. Please try again")
    end
  end
end
