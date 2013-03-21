require 'rubygems'
require 'aws-sdk'


# Change this stuff.
AWS.config({
             :access_key_id => "DUMMY",
             :secret_access_key => "DUMMY"
           })
bucket_name = 'selectors_choice'


s3 = AWS::S3.new()
bucket = s3.buckets[bucket_name]
bucket.objects.each do |object|
  puts object.key
  object.acl = :public_read
end
