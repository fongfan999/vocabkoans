module MessengerProfile
  PROPERTIES = {
    get_started: { payload: 'GET_STARTED_PAYLOAD' }
  }.freeze

  extend ActiveSupport::Concern

  Facebook::Messenger::Profile.set(PROPERTIES, access_token: ENV['ACCESS_TOKEN'])
end
