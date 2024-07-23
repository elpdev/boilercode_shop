class Product < ApplicationRecord
  include Github
  include Payments

  has_many :licenses, dependent: :destroy

  has_one_attached :featured_image

  scope :visible, -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }

  validates :name, :slug, presence: true, uniqueness: true
  validates :short_description, length: { maximum: 300 }

  before_validation do
    self.slug ||= name&.parameterize
  end

  def to_param = slug
end
