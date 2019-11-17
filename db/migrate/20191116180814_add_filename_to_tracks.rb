# frozen_string_literal: true

class AddFilenameToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :filename, :string
  end
end
