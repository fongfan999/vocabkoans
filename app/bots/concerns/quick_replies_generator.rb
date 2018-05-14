module QuickRepliesGenerator
  extend ActiveSupport::Concern

  def text_quick_replies(container)
    container.map do |title, payload, _image_url|
      { content_type: :text, title: title, payload: payload }
    end
  end
end
