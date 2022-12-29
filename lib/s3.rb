# frozen_string_literal: true

module SelectorsChoice
  class S3
    def initialize(key: nil, secret: nil, region: nil, bucket: nil)
      @bucket = bucket || Rails.application.credentials.aws.s3_bucket
      @client = Aws::S3::Client.new(
        access_key_id: key || Rails.application.credentials.aws.access_key_id,
        secret_access_key: secret || Rails.applcation.credentials.aws.secret_access_key,
        region: region || Rails.application.credentials.aws.region,
      )
    end

    def update_content_type(object, ctype)
      object.copy_to(object.key, content_type: ctype)
    end

    def get_presigned_url(key, opts = {})
      presigner.presigned_url(:get_object, opts.merge(bucket: @bucket, key:))
    end

    def presigner
      Aws::S3::Presigner.new(client: @client)
    end
  end
end
