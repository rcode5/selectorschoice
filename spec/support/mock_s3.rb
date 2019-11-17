# frozen_string_literal: true

def mock_s3(client_stubs = {})
  allow(SelectorsChoice::S3).to receive(:new).and_return(
    double(SelectorsChoice::S3, { get_presigned_url: 'presigned_url_${SecureRandom.hex(10)}' }.merge(client_stubs))
  )
end
