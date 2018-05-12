namespace :vocabulary do
  desc 'Inform users what words they will learn today'
  task inform_users: :environment do
    User.active.find_each { |user| Bot::Vocabulary::Informer.perform(user) }
  end

  desc 'Send new vocabularies in detail to users'
  task deliver: :environment do
    today_user_ids = Subscription.in_today.distinct.pluck(:user_id)

    User.where(id: today_user_ids).find_each do |user|
      # The maximum of duration will be the double of the time difference
      # Eg:
      # If the time difference is 15 then the duration will be between 0 and 30.
      # And this task will run at:
      # `(60 - the time difference) = 60 - 15 = 45th minutes`
      # so the job will be performed from hh:45 -> hh:15
      wait_duration = rand(0..TIME_DIFFERENCE_OF_VOCAB_DEVLIERY * 2).minutes
      DeliverDailyVocabularyJob.set(wait: wait_duration).perform_later(user)
    end
  end
end
