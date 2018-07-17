require 'sidekiq'

Sidekiq.configure_server do |config|
  config.average_scheduled_poll_interval = 5
  config.redis = { :namespace => 'gamify', :url => 'redis://localhost:6379/1' }
end

Sidekiq.configure_client do |config|
  config.redis = { :namespace => 'gamify', :url => 'redis://localhost:6379/1' }
end
