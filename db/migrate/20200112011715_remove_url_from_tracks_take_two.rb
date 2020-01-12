# frozen_string_literal: true

class RemoveUrlFromTracksTakeTwo < ActiveRecord::Migration[6.0]
  def up
    remove_column :tracks, :url
  end

  def down
    add_column :tracks, :url, :string
  end
end
