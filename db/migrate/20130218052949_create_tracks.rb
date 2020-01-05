class CreateTracks < ActiveRecord::Migration[4.2]
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :display_title
      t.text :playlist
      t.text :description
      t.datetime :recorded_on
      t.string :url

      t.timestamps
    end
  end
end
