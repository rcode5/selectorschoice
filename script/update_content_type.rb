require 'aws-sdk'

# log requests using the default rails logger
AWS.config(:logger => Rails.logger)
# load credentials from a file
config_path = File.expand_path(File.join(Rails.root, 'config','aws.yml'))
AWS.config(YAML.load(File.read(config_path)))

module SelectorsChoice
  class S3
    @@bucket = 'selectors_choice'

    def self.s3
      @@s3 ||= AWS::S3.new
    end

    def self.bucket
      s3.buckets[@@bucket]
    end

    def self.update_content_type(ob, ctype)
      ob.copy_to(ob.key, :content_type => ctype)
    end

  end
end


SelectorsChoice::S3.bucket.objects.each do |obj|
  if obj.key =~ /\.mp3$/
    SelectorsChoice::S3.update_content_type(obj, 'audio/mpeg')
  end
end


