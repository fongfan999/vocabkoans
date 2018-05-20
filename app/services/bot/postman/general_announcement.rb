module Postman
  class GeneralAnnouncement < Application

    def send_all
      all_messenger_uids.each do |messenger_uid|
        deliver_with(payload(messenger_uid))
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
      @all_messenger_uids = User.pluck(:messenger_uid)
    end
  end
end
