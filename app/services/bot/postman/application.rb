module Postman
  class Application < Bot::Base::Deliverer
    attr_reader :message

    def initialize(message)
      @message = message
    end
  end
end
