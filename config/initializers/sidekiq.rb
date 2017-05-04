Sidekiq::Enqueuer.configure do |config|
  config.jobs = [DmitryJob]
end

Sidekiq.configure_server do |config|
  config.redis = { host: Rails.application.config.redis_host, post: 6379, db: 1, namespace: 'sidekiq' }
end

Sidekiq.configure_client do |config|
  config.redis = { host: Rails.application.config.redis_host, post: 6379, db: 1, namespace: 'sidekiq' }
end
