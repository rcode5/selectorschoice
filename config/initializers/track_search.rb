# frozen_string_literal: true

Rails.application.config.after_initialize do
  require Rails.root.join('app/models/track')
  table_name = TrackSearch.table_name
  statements = [
    "drop table if exists #{table_name}",
    "create virtual table #{table_name} using fts5(title, description, playlist, tags, track_id)",
  ].freeze

  statements.each do |stmt|
    ActiveRecord::Base.connection.execute stmt
  end
  Track.reindex_all
end
