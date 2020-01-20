# frozen_string_literal: true

require Rails.root.join('lib/cloud_front')

class Track < ApplicationRecord
  validates :title, presence: true
  validates :filename, presence: true
  acts_as_taggable
  acts_as_taggable_on :styles

  def pretty_title
    display_title.presence || title
  end

  def signed_url
    SelectorsChoice::CloudFront.new.get_presigned_url(
      filename,
      expires: Time.current + 300.seconds
    )
  end

  class << self
    def by_recency
      order('recorded_on desc, updated_at desc')
    end

    def published
      where(published: true)
    end

    def unpublished
      where(published: [false, nil])
    end
  end
end
