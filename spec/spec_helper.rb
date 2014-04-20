$LOAD_PATH << File.expand_path('../lib', File.dirname(__FILE__))

if RUBY_VERSION >= '1.9'
  require 'simplecov'
  SimpleCov.start
end

require 'sun_times'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered   = true
  config.filter_run                         :focus
  config.order                              = 'random'
end
