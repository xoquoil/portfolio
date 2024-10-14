class Post < ApplicationRecord
  has_many :pins, dependent: :destroy
  accepts_nested_attributes_for :pins, allow_destroy: true

  validates :name, presence: true, length: { maximum: 255 }
end
