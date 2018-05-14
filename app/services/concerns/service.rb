module Service
  extend ActiveSupport::Concern

  class_methods do
    def perform(*args)
      new(*args).perform
    end
  end
end
