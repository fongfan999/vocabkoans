if Rails.env.development?
  Rails.application.config.to_prepare do
    Dir[File.join(Rails.root, 'app', 'bots', '*.rb')].each do |f|
      bot_name = File.basename(f, File.extname(f)).camelize
      bot_name.constantize unless Object.const_defined?(bot_name)
    end
  end
end
