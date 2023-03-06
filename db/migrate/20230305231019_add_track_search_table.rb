class AddTrackSearchTable < ActiveRecord::Migration[7.0]
  def up
    execute('create virtual table track_search using fts5(title, description, tracklist, tags, track_id)')
  end

  def down
    execute('drop table if exists track_search')
  end
end
