AlchemyAPI.configure do |config|
  config.apikey = Figaro.env.alchemy_key
end