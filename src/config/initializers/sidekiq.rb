Sidekiq.default_job_options = { 'retry' => 0 }

redis_options_development = {
  url: 'redis://localhost:6379/5',
  password: nil
}

redis_options_production = {
  url: Rails.application.credentials.dig(:redis, :url),
  password: Rails.application.credentials.dig(:redis, :password)
}

redis_options = Rails.env.production? ? redis_options_production : redis_options_development

Sidekiq.configure_server do |config|
  config.redis = redis_options
  config.logger = Rails.logger
end

Sidekiq.configure_client do |config|
  config.redis = redis_options
end
