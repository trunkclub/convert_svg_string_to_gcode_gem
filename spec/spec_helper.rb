ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'database_cleaner'
require_relative 'helpers'
require 'fixtures/spec_constants'

RSpec.configure do |config|
  config.include(Helpers)

  # Raise errors for deprecated rspec syntax
  config.raise_errors_for_deprecations!

  # Colored tests are more _exciting_
  config.color = true

  # Set the order to random unless we pass it in from the command line
  config.order = :rand unless ARGV.any? { |arg| %w(--order --seed).include?(arg) }

  #  Define DatabaseCleaner strategy
  # -------------------------------------------
  # config.before(:suite) do
    # DatabaseCleaner[:active_record].strategy = :transaction
    # DatabaseCleaner.clean_with(:truncation)
  # end

  #  Wire up DatabaseCleaner before and after each example
  # -------------------------------------------
  # config.around(:each) do |example|
    # DatabaseCleaner.cleaning do
      # example.run
    # end
  # end

end
