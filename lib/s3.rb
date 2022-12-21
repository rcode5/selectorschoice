# frozen_string_literal: true

module SelectorsChoice
  class S3
    BUCKET_NAME = ENV.fetch('AWS_S3_BUCKET', 'selectors_choice')

    def initialize
      @client = Aws::S3::Client.new(access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', nil),
                                    secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', nil),
                                    region: ENV.fetch('AWS_REGION', nil))
    end

    def update_content_type(object, ctype)
      object.copy_to(object.key, content_type: ctype)
    end

    def get_presigned_url(key, opts = {})
      presigner.presigned_url(:get_object, opts.merge(bucket: BUCKET_NAME, key:))
    end

    def presigner
      Aws::S3::Presigner.new(client: @client)
    end
  end
end
