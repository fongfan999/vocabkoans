require File.expand_path(File.dirname(__FILE__) + '/environment')

set :environment, Rails.env
set :output, Rails.root.join('log/cron.log').to_s
