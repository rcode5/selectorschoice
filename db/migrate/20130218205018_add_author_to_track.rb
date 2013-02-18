class AddAuthorToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :author, :string
  end
end
