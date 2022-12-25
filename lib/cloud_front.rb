# frozen_string_literal: true

module SelectorsChoice
  class CloudFront
    attr_reader :signer

    BUCKET_NAME = Rails.application.credentials.aws.s3_bucket
    CF_DOMAIN = "#{Rails.application.credentials.aws.cloud_front_domain}.cloudfront.net".freeze

    EXPIRY_IN_SECONDS = (60 * 60 * 6).seconds # 6hours - long enough for a whole track

    def initialize
      opts = {
        key_pair_id: Rails.application.credentials.aws.key_pair_id,
        private_key_path: Rails.application.credentials.aws.private_key_path,
        private_key: unpack_key(Rails.application.credentials.aws.private_key),
      }.compact
      @signer = Aws::CloudFront::UrlSigner.new(**opts)
    end

    def get_presigned_url(filename, opts = {})
      url = Addressable::URI.parse("https://#{CF_DOMAIN}/#{encode_s3_key(filename)}")
      opts[:expires] = Time.current + EXPIRY_IN_SECONDS
      signer.signed_url(url.to_s, opts)
    end

    private

    def encode_s3_key(s)
      s.tr(' ', '+')
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
