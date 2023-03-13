# frozen_string_literal: true

Rails.application.config.after_initialize do
  require Rails.root.join('app/models/track')
  table_name = TrackSearch.table_name
  statements = [
    "drop table if exists #{table_name}",
    "create virtual table #{table_name} using fts5(title, description, playlist, tags, track_id)",
  ].freeze
  begin
    statements.each do |stmt|
      ActiveRecord::Base.connection.execute stmt
    end
    Track.reindex_all
  rescue ActiveRecord::StatementInvalid => e
    Rails.logger.warn("Failed to execute initializer statement #{e} - ignoring this error")
  end
end
