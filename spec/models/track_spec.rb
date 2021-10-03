# frozen_string_literal: true

require 'rails_helper'

describe Track do
  before do
    freeze_time
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:filename) }
  end

  describe '.signed_url' do
    let(:mock_service) { mock_cloud_front(get_presigned_url: 'the signed url') }
    subject(:track) { FactoryBot.build(:track) }

    before do
      allow(Rails.configuration)
        .to receive(:track_expiry_in_seconds).and_return(250)
      mock_service
    end

    it 'builds a CloudFront signed url' do
      track.signed_url
      expect(mock_service).to have_received(:get_presigned_url).with(
        track.filename, expires: Time.current + 250.seconds
      )
    end
  end
end
