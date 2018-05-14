set :whenever_name, -> { "#{fetch(:application_name)}_#{fetch(:rails_env)}" }
set :whenever_output_path, -> { "#{fetch(:shared_path)}/log/cron.log" }

namespace :whenever do
  desc 'Update crontab'
  task update: :remote_environment do
    comment "Update crontab for #{fetch(:application_name)}"
    in_path fetch(:current_path) do
      command "#{fetch(:bundle_prefix)} whenever --update-crontab #{fetch(:whenever_name)} --set 'output=#{fetch(:whenever_output_path)}'"
    end
  end
end
