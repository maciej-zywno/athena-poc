Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.paths << Rails.root.join("vendor", "assets")
Rails.application.config.assets.paths << Rails.root.join("vendor", "assets", "fonts")
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|woff2|ttf|jpg)\z/