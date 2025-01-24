class Post < ApplicationRecord
  belongs_to :user
  has_many :pins, dependent: :destroy
  has_many :likes, dependent: :destroy
  accepts_nested_attributes_for :pins, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true, length: { maximum: 255 }

  def self.ransackable_attributes(_auth_object = nil)
    ["name"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["pins", "user"]
  end
end
