Spork.prefork do
  require 'bundler'
  Bundler.setup
  Bundler.require(:default, :test)
end

Spork.each_run do
  # This code will be run each time you run your specs.
end


Dir[File.expand_path("../factories/*.rb", __FILE__)].each { |f| require f }
