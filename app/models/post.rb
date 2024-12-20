class Post < ApplicationRecord
  belongs_to :user
  has_many :pins, dependent: :destroy
  has_many :likes, dependent: :destroy
  accepts_nested_attributes_for :pins, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true, length: { maximum: 255 }
end
