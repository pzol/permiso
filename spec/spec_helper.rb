require 'bundler'
Bundler.setup
Bundler.require(:default, :test)

Dir[File.expand_path("../factories/*.rb", __FILE__)].each { |f| require f }
