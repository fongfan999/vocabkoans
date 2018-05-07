require File.expand_path(File.dirname(__FILE__) + '/environment')

set :environment, Rails.env
set :output, Rails.root.join('log/cron.log').to_s

every 1.day, at: '0am' do
  rake 'vocabulary:inform_users'
end
