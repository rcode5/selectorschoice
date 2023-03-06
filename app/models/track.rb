# frozen_string_literal: true

require Rails.root.join('lib/cloud_front')

class Track < ApplicationRecord
  validates :title, presence: true
  validates :filename, presence: true
  acts_as_taggable
  acts_as_taggable_on :styles

  has_many :track_search, dependent: :destroy

  def pretty_title
    display_title.presence || title
  end

  def signed_url
    SelectorsChoice::CloudFront.new.get_presigned_url(
      filename,
      expires: Time.current + Rails.configuration.track_expiry_in_seconds.seconds,
    )
  end

  scope :by_recency, -> { order('recorded_on desc, updated_at desc') }
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: [nil, false]) }

  def reindex
    self.class.connection.execute self.class.sanitize_sql_for_conditions([
      'delete from track_search where track_id = ?', id
    ])
    self.class.connection.execute self.class.sanitize_sql(
      [
        'insert into track_search(track_id, title, description, tracklist, tags) values (?,?,?,?,?)', id,
        title, description, playlist, tags.join(' ')
      ],
    )
  end
end
