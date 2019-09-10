require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }
end

Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

class HardWorker
  include Sidekiq::Worker

  def perform(json)
    # do something
  end
end

# NOTE: Unknown parameters are passed to the underlying Redis client so any parameters supported by the driver can go in the Hash.

# NOTE: The configuration hash must have symbolized keys.