# frozen_string_literal: true

require 'rubygems'
require 'aws-sdk'

# log requests using the default rails logger
AWS.config(logger: Rails.logger)
# load credentials from a file
config_path = File.expand_path(File.join(Rails.root, 'config', 'aws.yml'))
AWS.config(YAML.safe_load(File.read(config_path)))

bucket_name = 'selectors_choice'

s3 = AWS::S3.new
bucket = s3.buckets[bucket_name]
bucket.objects.each do |object|
  puts object.key
  object.acl = :public_read
end
