Sidekiq.default_job_options = { 'retry' => 0 }

Sidekiq.configure_server do |config|
  redis_url = if Rails.env.production?
    Rails.application.credentials.dig(:redis, :url)
  else
    'redis://localhost:6379/5'
  end

  config.redis = { url: redis_url }
  config.logger = Rails.logger
end

Sidekiq.configure_client do |config|
  redis_url = if Rails.env.production?
    Rails.application.credentials.dig(:redis, :url)
  else
    'redis://localhost:6379/5'
  end

  config.redis = { url: redis_url }
end
