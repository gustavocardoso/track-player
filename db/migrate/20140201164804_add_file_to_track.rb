class AddFileToTrack < ActiveRecord::Migration[5.1]
  def change
    add_attachment :tracks, :file
  end
end
