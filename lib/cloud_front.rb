# frozen_string_literal: true

module SelectorsChoice
  class CloudFront
    attr_reader :signer

    BUCKET_NAME = ENV.fetch('AWS_S3_BUCKET', 'selectors_choice')

    EXPIRY_IN_SECONDS = (60 * 60 * 6).seconds) # 6hours - long enough for a whole track

    def initialize
      opts = {
        key_pair_id: ENV['AWS_KEY_PAIR_ID'],
        private_key_path: ENV['AWS_PRIVATE_KEY_PATH'],
        private_key: unpack_key(ENV['AWS_PRIVATE_KEY']),
      }.compact
      @signer = Aws::CloudFront::UrlSigner.new(**opts)
    end

    def get_presigned_url(filename, opts = {})
      url = Addressable::URI.parse("https://#{cf_domain}/#{ERB::Util.url_encode(filename)}")
      opts[:expires] = Time.current + EXPIRY_IN_SECONDS
      signer.signed_url(url.to_s, opts)
    end

    private

    def cf_domain
      "#{ENV.fetch('AWS_CLOUD_FRONT_DOMAIN')}.cloudfront.net"
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
