# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
# Rails.application.config.assets.precompile += %w( my_order.css )
Rails.application.config.assets.precompile += %w( icons/delete.png spree/frontend/cart.js logo/spree_50.png )
Rails.application.config.assets.precompile += %w( jquery.bxslider.js )
Rails.application.config.assets.precompile += %w( jquery.bxslider.css )
Rails.application.config.assets.precompile += %w( distpicker.js distpicker.data.js )
Rails.application.config.assets.precompile += %w( bootstrapValidator.js bootstrapValidator.css language/zh_CN.js )
Rails.application.config.assets.precompile += %w( glyphicons-halflings-regular.eot glyphicons-halflings-regular.svg glyphicons-halflings-regular.ttf glyphicons-halflings-regular.woff glyphicons-halflings-regular.woff2 )
Rails.application.config.assets.precompile += %w( jquery.bootstrap-touchspin.css jquery.bootstrap-touchspin.js )
