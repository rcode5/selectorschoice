# frozen_string_literal: true

Rails.application.config.after_initialize do
  puts 'AFTER INITIALIZER SETTING UP TRACK SEARCH'
  table_name = TrackSearch.table_name
  statements = [
    "drop table if exists #{table_name}",
    "create virtual table #{table_name} using fts5(title, description, playlist, tags, track_id)",
  ].freeze

  statements.each do |stmt|
    ActiveRecord::Base.connection.execute stmt
  end

  begin
    require Rails.root.join('app/models/track')

    Track.reindex_all
    puts 'REINDEXED'
    Rails.logger.info('Reindexed tracks for search')
  rescue ActiveRecord::StatementInvalid => e
    puts "FAILED #{e}"
  end
end
