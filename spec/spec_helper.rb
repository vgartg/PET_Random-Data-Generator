# frozen_string_literal: true

require 'date'

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))

require 'random_data_generator'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.disable_monkey_patching!
  config.filter_run_when_matching :focus
  config.order = :random
  Kernel.srand config.seed
end
