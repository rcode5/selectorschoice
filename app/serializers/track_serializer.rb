# frozen_string_literal: true

class TrackSerializer
  include FastJsonapi::ObjectSerializer
  attributes :signed_url
end
