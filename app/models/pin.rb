class Pin < ApplicationRecord
  belongs_to :post

  mount_uploader :image, ImageUploader
  
  validates :name, presence: true, length: { maximum: 255 }
  validates :address, length: { maximum: 255 }, allow_nil: true
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :body, length: { maximum: 65_535 }

  def image_url
    image.present? ? image.url : nil
  end
end
