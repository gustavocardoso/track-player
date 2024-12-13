class Track < ApplicationRecord
  before_save :normalize_volume
  has_one_attached :file

  validates :title, :artist, :bpm, :duration, presence: true
  validates :duration, format: { with: /\A([0-9]?[0-9]):([0-9][0-9])\z/ }
  validate :correct_file_mime_type

  private

  def normalize_volume
    self.volume = volume.to_f
  end

  def correct_file_mime_type
    if file.attached? && !file.content_type.in?(%w(audio/mpeg audio/wav audio/mp3 audio/ogg))
      errors.add(:file, 'must be an audio file')
    elsif file.attached? == false
      errors.add(:file, 'must be attached')
    end
  end
end
