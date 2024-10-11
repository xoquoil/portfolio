class Post < ApplicationRecord
  has_many :pins, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
end
