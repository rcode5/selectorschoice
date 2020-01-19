# frozen_string_literal: true

module WithModifiedEnv
  def with_modified_env(options, &block)
    ClimateControl.modify(options, &block)
  end
end

RSpec.configure do |config|
  config.include WithModifiedEnv
end
