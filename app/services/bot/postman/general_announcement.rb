module Postman
  class GeneralAnouncement < Application

    def send_all
      all_messenger_uids.each do |messenger_uid|
        Facebook::Messenger::Bot.deliver(
          payload(messenger_uid), access_token: ENV['ACCESS_TOKEN']
        )
      end
    end

    private

    def payload(messenger_uid)
      {
        recipient:       { id: messenger_uid },
        message:         { text: message },
        messaging_type: 'MESSAGE_TAG',
        tag:            'APPLICATION_UPDATE'
      }
    end

    def all_messenger_uids
      @all_messenger_uids = User.all.map(&:messenger_uid)
    end
  end
end
