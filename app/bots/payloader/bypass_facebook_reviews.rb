module Payloader
  class BypassFacebookReviews < Application
    def perform
      lowercase_text = bot.text.downcase

      return GetStarted.new(bot).perform if lowercase_text == 'get started'
      return SetWordsOfTheDay.new(bot).perform if lowercase_text == 'yes'
      return CompleteSubscription.new(bot).perform if lowercase_text =~ /\d words?/
      return CancelSubscription.new(bot).perform if %w(cancel no).include?(lowercase_text)

      bot.reply(text: 'Hi there, please click the "Get Started" button on the persisted menu and follow the instructions')
    end
  end
end
