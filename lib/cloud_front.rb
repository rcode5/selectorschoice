# frozen_string_literal: true

module SelectorsChoice
  class CloudFront
    attr_reader :signer

    EXPIRY_IN_SECONDS = (60 * 60 * 6) # 6hours - long enough for a whole track

    def initialize(cloud_front_domain: nil)
      @cloud_front_domain = cloud_front_domain ||
                            "#{Rails.application.credentials.aws.cloud_front_domain}.cloudfront.net"

      opts = {
        key_pair_id: Rails.application.credentials.aws.key_pair_id,
        private_key_path: Rails.application.credentials.aws.private_key_path,
        private_key: unpack_key(Rails.application.credentials.aws.private_key),
      }.compact
      @signer = Aws::CloudFront::UrlSigner.new(**opts)
    end

    def get_presigned_url(filename, opts = {})
      url = Addressable::URI.parse("https://#{@cloud_front_domain}/#{encode_s3_key(filename)}")
      opts[:expires] = Time.current + EXPIRY_IN_SECONDS.seconds
      signer.signed_url(url.to_s, opts)
    end

    private

    def encode_s3_key(s3_key)
      s3_key.tr(' ', '+')
    end

    def unpack_key(key)
      return if key.blank?

      # if we have to use a key from an env var directly,
      # it should have '\n' (2 characters) encoded into it where
      # newlines should be.  This function will replace those with
      # actual newlines
      key.gsub('\n', "\n")
    end
  end
end
