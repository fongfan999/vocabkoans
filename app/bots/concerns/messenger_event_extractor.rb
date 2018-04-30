module MessengerEventExtractor
  CLASS_NAME_SUFFIX = 'Bot'.freeze

  extend ActiveSupport::Concern

  class_methods do
    def messenger_eventify(klass)
      klass_name = klass.name
      klass_name.chomp!(CLASS_NAME_SUFFIX)

      klass_name.underscore.to_sym
    end
  end
end
