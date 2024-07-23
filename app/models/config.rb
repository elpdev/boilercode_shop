class Config < ApplicationRecord
  has_one_attached :logo
  has_one_attached :opengraph_image

  validates :description, length: { maximum: 300 }
end
