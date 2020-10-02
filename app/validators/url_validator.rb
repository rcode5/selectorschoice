# frozen_string_literal: true

require 'addressable/uri'
class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    valid = begin
      Addressable::URI.parse(value).is_a?(Addressable::URI)
    rescue URI::InvalidURIError
      false
    end
    return if valid

    record.errors.add(attribute) << (options[:message] || 'is an invalid URL')
  end
end
