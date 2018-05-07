class DailyVocabulary
  attr_reader :user, :random_availabilities

  def initialize(user)
    @user = user
  end

  def save
    return false if user.subscriptions.created_in_today.exists?

    params = random_availabilities.map { |vocab| { vocabulary_id: vocab.id } }
    user.subscriptions.build(params)
    user.save
  end

  def random_availabilities
    @_random_availabilities ||= availabilities.random(user.words_of_the_day)
  end

  def availabilities
    Vocabulary
      .without_sense
      .where.not(id: user.subscriptions.pluck(:vocabulary_id))
  end

  def formatted
    random_availabilities
      .map.with_index { |vocab, index| _formatted_vocab(vocab, index) }
      .join("\n")
  end

  private

  def _formatted_vocab(vocabulary, index = 0)
    "#{index + 1}. #{vocabulary.word} (#{vocabulary.word_class})"
  end
end
