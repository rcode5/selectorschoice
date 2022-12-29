# frozen_string_literal: true

require_relative '../../lib/cloud_front'
require 'rails_helper'

describe SelectorsChoice::CloudFront do
  let(:mock_signer) do
    double(Aws::CloudFront::UrlSigner, signed_url: "aws_cloudfront_urlsigner#{SecureRandom.hex(10)}")
  end

  before do
    stub_credentials(aws: { cloud_front_domain: 'the.cf.domain' })
    freeze_time
    allow(Aws::CloudFront::UrlSigner).to receive(:new).and_return(mock_signer)
  end

  describe '.get_presigned_url' do
    it 'builds the cloudfront url and returns a signed version of that' do
      described_class.new.get_presigned_url('abc def.mp3', whatever: 'opts')
      expect(mock_signer).to have_received(:signed_url)
        .with("https://#{Rails.application.credentials.aws.cloud_front_domain}.cloudfront.net/abc+def.mp3",
              expires: Time.current + (60 * 60 * 6).seconds, whatever: 'opts')
    end
  end
end
