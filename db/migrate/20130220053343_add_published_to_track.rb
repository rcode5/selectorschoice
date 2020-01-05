class AddPublishedToTrack < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :published, :boolean
  end
end
