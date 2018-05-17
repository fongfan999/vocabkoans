if Rails.env.development?
  Rails.application.config.to_prepare do
    Dir[File.join(Rails.root, 'app', 'bots', '*.rb')].each do |f|
      bot_name = File.basename(f, File.extname(f)).camelize
      bot_name.constantize unless Object.const_defined?(bot_name)
    end
  end
end

MESSENGER_PROPERTIES = {
  get_started: { payload: 'GET_STARTED' },
  persistent_menu: [
    {
      locale: 'default',
      composer_input_disabled: true,
      call_to_actions: [
        { type: 'postback', title: 'Get Started', payload: 'GET_STARTED' },
        { type: 'web_url',  title: 'Feedback',    url: 'https://goo.gl/forms/t5zzRizb9HNrw94I3' }
      ]
    }
  ]
}.deep_freeze

Facebook::Messenger::Profile.set(MESSENGER_PROPERTIES, access_token: ENV['ACCESS_TOKEN'])
