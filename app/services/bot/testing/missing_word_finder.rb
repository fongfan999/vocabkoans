class Bot::Testing::MissingWordFinder < Bot::Testing::Application
  def perform
    deliver_with default_payload.merge(message: { text: 'MissingWordFinder' })
  end
end
