require 'rubygems'
require 'bundler/setup'

require 'active_support'
require 'support/active_record'

require 'easy_dates'

RSpec.configure do |config|
  config.mock_with :rspec

  config.alias_it_should_behave_like_to :it_has, 'has'

  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end
