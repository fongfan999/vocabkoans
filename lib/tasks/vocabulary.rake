namespace :vocabulary do
  desc 'Inform users what words they will learn today'
  task inform_users: :environment do
    User.active.find_each { |user| Bot::Vocabulary::Informer.perform(user) }
  end
end
