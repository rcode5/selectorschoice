# frozen_string_literal: true

require 'aws-sdk'

client = SelectorsChoice::S3.new
client.bucket.objects.each do |obj|
  obj.key.match?(/\.mp3$/) && client.update_content_type(obj, 'audio/mpeg')
end
