if ENV["RAILS_ENV"] == "development"
  worker_processes 1
else
  worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
end

timeout 30

preload_app true

before_fork do |server, worker|
  # @sidekiq_pid ||= spawn("bundle exec sidekiq -c 2")
  @sidekiq_pid ||= spawn("bundle exec sidekiq")

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
