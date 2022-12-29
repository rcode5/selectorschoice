# frozen_string_literal: true

module MockCredentials
  def stub_credentials(credentials)
    # rubocop:disable Style/OpenStructUse
    allow(Rails.application).to receive(:credentials).and_return(
      JSON.parse(credentials.to_json, object_class: OpenStruct),
    )
    # rubocop:enable Style/OpenStructUse
  end
end

RSpec.configure do |config|
  config.include MockCredentials
end
