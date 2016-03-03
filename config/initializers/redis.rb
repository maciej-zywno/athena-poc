if ENV['REDISCLOUD_URL']
  uri = URI.parse(ENV['REDISCLOUD_URL'])
  REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
elsif ENV['REDISTOGO_URL']
  uri = URI.parse(ENV['REDISTOGO_URL'])
  REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
elsif ENV['WERCKER_REDIS_HOST'] && ENV['WERCKER_REDIS_PORT'] # wercker ci
  REDIS = Redis.new(host: ENV['WERCKER_REDIS_HOST'], port: ENV['WERCKER_REDIS_PORT'])
else
  REDIS = Redis.new
end
