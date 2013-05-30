Sidekiq.configure_client do |config|
  config.redis = { :url => 'redis://127.0.0.1:6379/0' , :size => 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { :url => 'redis://127.0.0.1:6379/0', :size => 3 }
end
