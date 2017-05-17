Sidekiq::Enqueuer.configure do |config|
  config.jobs = [SidekiqLowJob, SidekiqDefaultJob, SidekiqHighJob]
end

Sidekiq.configure_server do |config|
  config.redis = {
    host: Rails.application.config.sidekiq_redis_host,
    port: 6379,
    db: Rails.application.config.sidekiq_redis_db,
    namespace: 'sidekiq'
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    host: Rails.application.config.sidekiq_redis_host,
    port: 6379,
    db: Rails.application.config.sidekiq_redis_db,
    namespace: 'sidekiq'
  }
end
