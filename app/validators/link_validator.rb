# a little lighter than url
# either url validation if it starts with http[s]:
# else starts with / (relative paths to the local server)
class LinkValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    valid = begin
              if /https?:/ =~ value
                URI.parse(value).kind_of?(URI::HTTP)
              else
                /^\/[\S]*$/ =~ value
              end
            rescue URI::InvalidURIError
              false
            end
    unless valid
      record.errors[attribute] << (options[:message] || "is an invalid link - if it starts with http: it must be a valid url, otherwise it should start with '/' because we will use a relative path")
    end
  end

end
