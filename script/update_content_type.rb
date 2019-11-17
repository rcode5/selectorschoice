# frozen_string_literal: true

# # frozen_string_literal: true

require 'aws-sdk'

# # log requests using the default rails logger
# AWS.config(logger: Rails.logger)
# # load credentials from a file
# config_path = File.expand_path(File.join(Rails.root, 'config', 'aws.yml'))
# AWS.config(YAML.safe_load(File.read(config_path)))

client = SelectorsChoice::S3.new
client.bucket.objects.each do |obj|
  obj.key.match?(/\.mp3$/) && client.update_content_type(obj, 'audio/mpeg')
end
