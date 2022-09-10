# frozen_string_literal: true

# a little lighter than url
# either url validation if it starts with http[s]:
# else starts with / (relative paths to the local server)
class LinkValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    valid = begin
      if /https?:/.match?(value)
        URI.parse(value).is_a?(URI::HTTP)
      else
        %r{^/\S*$} =~ value
      end
    rescue URI::InvalidURIError
      false
    end
    return if valid

    msg = options[:message] || 'is an invalid link - if it starts with ' \
                               'http: it must be a valid url, otherwise ' \
                               "it should start with '/' because we will " \
                               'use a relative path'
    record.errors.add(attribute, msg)
  end
end
