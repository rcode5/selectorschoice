# frozen_string_literal: true

require_relative '../../lib/cloud_front'

def mock_cloud_front(client_stubs = {})
  mock_service = double(SelectorsChoice::CloudFront, {
    get_presigned_url: "presigned_url_#{SecureRandom.hex(10)}",
  }.merge(client_stubs))
  allow(SelectorsChoice::CloudFront).to receive(:new).and_return(mock_service)
  mock_service
end
