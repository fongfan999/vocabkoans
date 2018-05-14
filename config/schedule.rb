require File.expand_path(File.dirname(__FILE__) + '/environment')

set :environment, Rails.env

every 1.day, at: '0am' do
  rake 'vocabulary:inform'
end

# Eg: Run from 7:45AM to 7:45PM, every 1 hour when the time difference is 15
every "#{60 - TIME_DIFFERENCE_OF_VOCAB_DEVLIERY} 7-20/1 * * *" do
  rake 'vocabulary:deliver'
end

every 1.day, at: '2pm' do
  rake 'vocabulary:summarize'
end
