require 'addressable/uri'
class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    valid = begin
      Addressable::URI.parse(value).kind_of?(Addressable::URI)
    rescue URI::InvalidURIError
      false
    end
    unless valid
      record.errors[attribute] << (options[:message] || "is an invalid URL")
    end
  end

end
