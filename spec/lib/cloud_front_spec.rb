# frozen_string_literal: true

require_relative '../../lib/cloud_front'
require 'rails_helper'

describe SelectorsChoice::CloudFront do
  let(:mock_signer) do
    double(Aws::CloudFront::UrlSigner, signed_url: "aws_cloudfront_urlsigner#{SecureRandom.hex(10)}")
  end

  before do
    freeze_time
    allow(Aws::CloudFront::UrlSigner).to receive(:new).and_return(mock_signer)
  end
  after do
    travel_back
  end

  it 'sets up the cloudfront signer with the right options' do
    with_modified_env(
      AWS_PRIVATE_KEY_PATH: 'the pk.pem path',
      AWS_KEY_PAIR_ID: 'my key pair id',
    ) do
      described_class.new
      expect(Aws::CloudFront::UrlSigner).to have_received(:new).with(key_pair_id: 'my key pair id',
                                                                     private_key_path: 'the pk.pem path')
    end
  end

  it 'unpacks the PRIVATE_KEY if that was provided' do
    with_modified_env(
      AWS_PRIVATE_KEY: 'abc\ndef rbg\n',
      AWS_KEY_PAIR_ID: 'my key pair id',
    ) do
      described_class.new
      expect(Aws::CloudFront::UrlSigner).to have_received(:new).with(key_pair_id: 'my key pair id',
                                                                     private_key: "abc\ndef rbg\n")
    end
  end

  describe '.get_presigned_url' do
    it 'builds the cloudfront url and returns a signed version of that' do
      with_modified_env(
        AWS_CLOUD_FRONT_DOMAIN: 'my-cloudfront-domain',
        AWS_KEY_PAIR_ID: 'my key pair id',
      ) do
        described_class.new.get_presigned_url('abc def.mp3', whatever: 'opts')
        expect(mock_signer).to have_received(:signed_url)
          .with('https://my-cloudfront-domain.cloudfront.net/abc%20def.mp3',
                expires: Time.current + 300.seconds, whatever: 'opts')
      end
    end
  end
end
