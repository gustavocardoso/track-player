class AddVolumeToTracks < ActiveRecord::Migration[5.1]
  def change
    add_column :tracks, :volume, :integer
  end
end
