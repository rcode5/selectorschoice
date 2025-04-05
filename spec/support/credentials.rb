# frozen_string_literal: true

module MockCredentials
  class MockAws
    include ActiveModel::Model
    attr_accessor :access_key,
                  :cloud_front_domain,
                  :key_pair_id,
                  :private_key,
                  :private_key_path,
                  :region,
                  :s3_bucket,
                  :secret_access_key
  end

  class MockCreds
    include ActiveModel::Model

    attr_accessor :secret_key_base
    attr_writer :aws

    def aws
      MockAws.new(@aws)
    end
  end

  def stub_credentials(credentials)
    allow(Rails.application).to receive(:credentials).and_return(
      MockCreds.new(credentials),
    )
  end
end

RSpec.configure do |config|
  config.include MockCredentials
end
