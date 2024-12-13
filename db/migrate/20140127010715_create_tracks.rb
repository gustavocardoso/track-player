class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :artist
      t.integer :bpm
      t.string :duration
      t.text :observations
      t.timestamps
    end
  end
end
